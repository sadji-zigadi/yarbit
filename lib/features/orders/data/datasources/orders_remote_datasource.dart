import 'package:client/features/orders/data/models/order_model.dart';
import 'package:client/features/orders/domain/entities/order_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class OrdersRemoteDatasource {
  Future<void> createOrder({required OrderEntity order});
  Future<List<OrderEntity>> getOrders();
  Future<void> deleteOrder({required OrderEntity order});
}

class OrdersRemoteDatasourceImpl implements OrdersRemoteDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  OrdersRemoteDatasourceImpl(this._firestore, this._auth);

  @override
  Future<void> createOrder({required OrderEntity order}) async {
    order = order.copyWith(clientId: _auth.currentUser!.uid);
    final orderModel = order.mapToModel();

    await _firestore
        .collection('orders')
        .doc(orderModel.id)
        .set(orderModel.toMap());
  }

  @override
  Future<List<OrderEntity>> getOrders() async {
    final id = _auth.currentUser!.uid;
    List<OrderEntity> orders = [];

    final docs = await _firestore
        .collection('orders')
        .where('client id', isEqualTo: id)
        .get()
        .then((a) => a.docs);

    for (final b in docs) {
      final data = b.data();
      final companyData = await _firestore
          .collection('companies')
          .doc(data['company id'])
          .get()
          .then((c) => c.data());

      orders.add(OrderModel.fromMap(
        map: b.data(),
        companyName: companyData?['name'],
        companyPhoneNumber: companyData?['phone number'],
        companyServices: companyData?['services'],
        companyPictureUrl: companyData?['picture url'],
      ).mapToEntity());
    }

    return orders;
  }

  @override
  Future<void> deleteOrder({required OrderEntity order}) async {
    await _firestore.collection('orders').doc(order.id).delete();
  }
}
