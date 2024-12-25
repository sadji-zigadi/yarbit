import 'package:client/features/orders/domain/entities/order_entity.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/utils/network_info.dart';
import '../datasources/orders_remote_datasource.dart';
import '../../domain/repositories/orders_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  final OrdersRemoteDatasource _remote;
  final NetworkInfo _networkInfo;

  OrdersRepositoryImpl(this._remote, this._networkInfo);

  @override
  Future<Either<Failure, Unit>> createOrder(
      {required OrderEntity order}) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remote.createOrder(order: order);

        return const Right(unit);
      } on FirebaseException catch (e) {
        return Left(ServerFailure(e.code));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders() async {
    if (await _networkInfo.isConnected) {
      try {
        final orders = await _remote.getOrders();

        return Right(orders);
      } on FirebaseException catch (e) {
        return Left(ServerFailure(e.code));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteOrder(
      {required OrderEntity order}) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remote.deleteOrder(order: order);

        return const Right(unit);
      } on FirebaseException catch (e) {
        return Left(ServerFailure(e.code));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
