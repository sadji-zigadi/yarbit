import 'package:client/core/failure/failure.dart';
import 'package:client/features/orders/domain/entities/order_entity.dart';
import 'package:client/features/orders/domain/repositories/orders_repository.dart';
import 'package:dartz/dartz.dart';

class GetOrdersUsecase {
  final OrdersRepository _repository;

  GetOrdersUsecase(this._repository);

  Future<Either<Failure, List<OrderEntity>>> call() async =>
      await _repository.getOrders();
}
