import 'package:client/core/failure/failure.dart';
import 'package:client/features/orders/domain/entities/order_entity.dart';
import 'package:client/features/orders/domain/repositories/orders_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteOrderUsecase {
  final OrdersRepository _repository;

  const DeleteOrderUsecase(this._repository);

  Future<Either<Failure, Unit>> call({required OrderEntity order}) async =>
      await _repository.deleteOrder(order: order);
}
