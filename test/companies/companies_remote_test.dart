import 'package:client/core/shared/entities/company_entity.dart';
import 'package:client/features/companies/data/datasources/companies_remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocking.dart';

void main() {
  late CompaniesRemoteDatasource remote;
  late MockFirebaseFirestore firestore;

  setUp(() {
    firestore = MockFirebaseFirestore();
    remote = CompaniesRemoteDatasourceImpl(firestore);
  });

  group(
    'Companies remote testing',
    () {
      test(
        'Given no value, When getCompanies is invoked, Then a list of CompanyEntity will be returned',
        () async {
          // Arrange
          final colRef = MockCollectionReference();
          final querySnap = MockQuerySnapshot();
          final docs = [MockQueryDocumentSnapshot()];
          final docs2 = [MockQueryDocumentSnapshot()];
          final data = {
            'address': {
              'commune': 'commune',
              'wilaya': 'wilaya',
            },
            'category id': 'category_id',
            'description': 'description',
            'email': 'company_email',
            'id': 'company_id',
            'name': 'name',
            'phone number': 'phone_number',
            'picture url': 'picture_url',
            'services': ['services'],
          };
          final docRef = MockDocumentReference();
          final docSnap = MockDocumentSnapshot();
          final data2 = {
            'id': 'category_id',
            'name': 'category_name',
          };
          final query = MockQuery();
          final data3 = {
            'client id': 'client_id',
            'company id': 'company_id',
            'id': 'rating_id',
            'rating': 3,
          };

          when(() => firestore.collection('companies')).thenReturn(colRef);
          when(() => colRef.get()).thenAnswer((_) async => querySnap);
          when(() => querySnap.docs).thenReturn(docs);
          when(() => docs[0].data()).thenReturn(data);
          when(() => docs[0].id).thenReturn('company_id');

          when(() => firestore.collection('categories')).thenReturn(colRef);
          when(() => colRef.doc('category_id')).thenReturn(docRef);
          when(() => docRef.get()).thenAnswer((_) async => docSnap);
          when(() => docSnap.data()).thenReturn(data2);

          when(() => firestore.collection('ratings')).thenReturn(colRef);
          when(() => colRef.where('company id', isEqualTo: 'company_id'))
              .thenReturn(query);
          when(() => query.get()).thenAnswer((_) async => querySnap);
          when(() => querySnap.docs).thenReturn(docs2);
          when(() => docs2[0].data()).thenReturn(data3);

          // Act
          final companies = await remote.getCompanies();

          // Assert
          expect(companies, isA<List<CompanyEntity>>());
        },
      );
    },
  );
}
