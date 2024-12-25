import 'package:client/features/orders/domain/entities/order_entity.dart';

import '../../../../core/failure/failure.dart';
import '../repositories/orders_repository.dart';
import 'package:dartz/dartz.dart';

class CreateOrderUsecase {
  final OrdersRepository _repository;

  CreateOrderUsecase(this._repository);

  Future<Either<Failure, Unit>> call({required OrderEntity order}) async =>
      await _repository.createOrder(order: order);
}
