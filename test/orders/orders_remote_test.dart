import 'package:client/features/orders/data/datasources/orders_remote_datasource.dart';
import 'package:client/features/orders/domain/entities/order_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocking.dart';

main() {
  late OrdersRemoteDatasource remote;
  late MockFirebaseFirestore firestore;
  late MockFirebaseAuth auth;

  setUp(() {
    firestore = MockFirebaseFirestore();
    auth = MockFirebaseAuth();
    remote = OrdersRemoteDatasourceImpl(firestore, auth);
  });

  test(
    'Given an OrderEntity, When createOrder is invoked, Then no value is returned',
    () async {
      // Arrange
      final user = MockUser();
      final colRef = MockCollectionReference();
      final docRef = MockDocumentReference();
      final order = OrderEntity(
        companyId: 'company_id',
        companyName: 'company_name',
        companyPhoneNumber: 'company_phone_number',
        companyServices: const ['company_serivces'],
        companyPictureUrl: 'company_picture_url',
        date: DateTime.now(),
      ).mapToModel();

      when(() => auth.currentUser).thenAnswer((_) => user);
      when(() => user.uid).thenAnswer((_) => 'client_id');
      when(() => firestore.collection('orders')).thenAnswer((_) => colRef);
      when(() => colRef.doc(order.id)).thenAnswer((_) => docRef);
      when(() => docRef.set(order.toMap()));

      // Act

      // Assert
    },
  );

  test(
    'Given no value, When getOrders is invoked, Then a list of OrderEntity is returned',
    () async {
      // Arrange
      final user = MockUser();
      final colRef = MockCollectionReference();
      final colRef2 = MockCollectionReference();
      final query = MockQuery();
      final querySnap = MockQuerySnapshot();
      final docs = [MockQueryDocumentSnapshot()];
      final data = {
        'client id': 'client_id',
        'company id': 'company_id',
        'date': Timestamp.now(),
        'id': 'order_id',
      };
      final docRef = MockDocumentReference();
      final docSnap = MockDocumentSnapshot();
      final data2 = {
        'address': {
          'commune': 'commune',
          'wilaya': 'wilaya',
        },
        'category id': 'category_id',
        'description': 'description',
        'email': 'email',
        'id': 'company_id',
        'name': 'name',
        'phone number': 'phone number',
        'picture url': 'picture url',
        'services': ['services'],
      };

      when(() => auth.currentUser).thenAnswer((_) => user);
      when(() => user.uid).thenAnswer((_) => 'client_id');
      when(() => firestore.collection('orders')).thenAnswer((_) => colRef);
      when(() => colRef.where('client id', isEqualTo: 'client_id'))
          .thenAnswer((_) => query);
      when(() => query.get()).thenAnswer((_) async => querySnap);
      when(() => querySnap.docs).thenAnswer((_) => docs);
      when(() => docs[0].data()).thenAnswer((_) => data);
      when(() => firestore.collection('companies')).thenAnswer((_) => colRef2);
      when(() => colRef2.doc('company_id')).thenAnswer((_) => docRef);
      when(() => docRef.get()).thenAnswer((_) async => docSnap);
      when(() => docSnap.data()).thenAnswer((_) => data2);

      // Act
      final orders = await remote.getOrders();

      // Assert
      expect(orders, isA<List<OrderEntity>>());
    },
  );

  test(
    'Given an OrderEntity, When deleteOrder is invoked, Than no value is returned',
    () async {
      // Arrange
      final colRef = MockCollectionReference();
      final docRef = MockDocumentReference();
      final order = OrderEntity(
        companyId: 'company_id',
        companyName: 'company_name',
        companyPhoneNumber: 'company_phone_number',
        companyServices: const ['company_serivces'],
        companyPictureUrl: 'company_picture_url',
        date: DateTime.now(),
      );

      when(() => firestore.collection('orders')).thenAnswer((_) => colRef);
      when(() => colRef.doc(order.id)).thenAnswer((_) => docRef);
      when(() => docRef.delete()).thenAnswer((_) async {});

      // Act
      await remote.deleteOrder(order: order);

      // Assert
      verify(() => docRef.delete()).called(1);
    },
  );
}
