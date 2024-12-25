import 'package:client/features/orders/domain/entities/order_entity.dart';

import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';

abstract class OrdersRepository {
  Future<Either<Failure, Unit>> createOrder({required OrderEntity order});
  Future<Either<Failure, List<OrderEntity>>> getOrders();
  Future<Either<Failure, Unit>> deleteOrder({required OrderEntity order});
}
