import 'package:client/core/utils/entity_structure.dart';
import 'package:client/core/utils/enums.dart';
import 'package:client/features/orders/data/models/order_model.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class OrderEntity extends Equatable
    with EntityStructure<OrderEntity, OrderModel> {
  final String id;
  final String? clientId;
  final String companyId;
  final String companyName;
  final String companyPhoneNumber;
  final List<dynamic> companyServices;
  final String companyPictureUrl;
  final DateTime date;
  final OrderStatus status;

  OrderEntity({
    String? id,
    required this.companyId,
    required this.companyName,
    required this.companyPhoneNumber,
    required this.companyServices,
    required this.companyPictureUrl,
    required this.date,
    this.status = OrderStatus.pending,
    this.clientId,
  }) : id = id ?? const Uuid().v1();

  @override
  OrderEntity copyWith({
    String? id,
    String? companyId,
    String? companyName,
    String? companyPhoneNumber,
    List<String>? companyServices,
    String? companyPictureUrl,
    String? clientId,
    DateTime? date,
    OrderStatus? status,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      companyName: companyName ?? this.companyName,
      companyPhoneNumber: companyPhoneNumber ?? this.companyPhoneNumber,
      companyServices: companyServices ?? this.companyServices,
      companyPictureUrl: companyPictureUrl ?? this.companyPictureUrl,
      clientId: clientId ?? this.clientId,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }

  @override
  OrderModel mapToModel() {
    return OrderModel(
      id: id,
      companyId: companyId,
      clientId: clientId,
      date: date,
      companyServices: companyServices,
      companyName: companyName,
      companyPhoneNumber: companyPhoneNumber,
      companyPictureUrl: companyPictureUrl,
      status: status,
    );
  }

  @override
  List<Object?> get props => [
        id,
        companyId,
        clientId,
        date,
        companyServices,
        companyName,
        companyPhoneNumber,
        companyPictureUrl,
        status,
      ];
}
