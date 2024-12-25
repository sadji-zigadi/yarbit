import 'package:client/features/home/data/datasources/categories_remote_datasource.dart';
import 'package:client/features/home/data/datasources/home_remote_datasource.dart';
import 'package:client/features/home/data/models/category_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocking.dart';

main() {
  late HomeRemoteDatasource remoteHome;
  late CategoriesRemoteDatasource remoteCategories;
  late MockFirebaseFirestore firestore;

  setUp(() {
    firestore = MockFirebaseFirestore();
    remoteHome = HomeRemoteDatasourceImpl(firestore);
    remoteCategories = CategoriesRemoteDatasourceImpl(firestore);
  });

  test(
    'Given no value, When getPictures is invoked, Then a List<String> is returned',
    () async {
      // Arrange
      final colRef = MockCollectionReference();
      final querySnap = MockQuerySnapshot();
      final docs = [MockQueryDocumentSnapshot()];
      final data = {
        'picture url': 'picture url',
      };

      when(() => firestore.collection('pictures')).thenAnswer((_) => colRef);
      when(() => colRef.get()).thenAnswer((_) async => querySnap);
      when(() => querySnap.docs).thenReturn(docs);
      when(() => docs[0].data()).thenReturn(data);

      // Act
      final res = await remoteHome.getPictures();

      // Assert
      expect(res, isA<List<String>>());
    },
  );

  test(
    'Given no value, When getCategories is invoked, Then a list of CategoryModel is returned',
    () async {
      // Arrange
      final colRef = MockCollectionReference();
      final querySnap = MockQuerySnapshot();
      final docs = [MockQueryDocumentSnapshot()];
      final data = {
        'id': 'id',
        'name': 'name',
      };

      when(() => firestore.collection('categories')).thenAnswer((_) => colRef);
      when(() => colRef.get()).thenAnswer((_) async => querySnap);
      when(() => querySnap.docs).thenAnswer((_) => docs);
      when(() => docs[0].data()).thenAnswer((_) => data);

      // Act
      final categories = await remoteCategories.getCategories();

      // Assert
      expect(
        categories,
        isA<List<CategoryModel>>(),
      );
    },
  );
}
