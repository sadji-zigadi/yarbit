import 'package:client/core/utils/enums.dart';
import 'package:client/core/utils/model_structure.dart';
import 'package:client/features/orders/domain/entities/order_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel extends OrderEntity with ModelStructure<OrderEntity> {
  OrderModel({
    required super.id,
    required super.companyId,
    required super.clientId,
    required super.date,
    required super.companyName,
    required super.companyPhoneNumber,
    required super.companyServices,
    required super.companyPictureUrl,
    required super.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'company id': companyId,
      'client id': clientId,
      'date': date,
      'status': status.value,
    };
  }

  factory OrderModel.fromMap({
    required Map<String, dynamic> map,
    required String companyName,
    required String companyPhoneNumber,
    required List<dynamic> companyServices,
    required String companyPictureUrl,
  }) {
    return OrderModel(
      id: map['id'],
      clientId: map['client id'],
      companyId: map['company id'],
      date: (map['date'] as Timestamp).toDate(),
      companyServices: companyServices,
      companyName: companyName,
      companyPhoneNumber: companyPhoneNumber,
      companyPictureUrl: companyPictureUrl,
      status: OrderStatusParsing.fromValue(map['status']),
    );
  }

  @override
  OrderEntity mapToEntity() {
    return OrderEntity(
      id: id,
      companyId: companyId,
      clientId: clientId,
      date: date,
      companyName: companyName,
      companyServices: companyServices,
      companyPhoneNumber: companyPhoneNumber,
      companyPictureUrl: companyPictureUrl,
      status: status,
    );
  }
}
