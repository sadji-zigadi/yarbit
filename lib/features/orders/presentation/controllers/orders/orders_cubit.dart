import 'package:bloc/bloc.dart';
import 'package:client/features/orders/domain/entities/order_entity.dart';
import 'package:client/features/orders/domain/usecases/delete_order_usecase.dart';
import 'package:client/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:equatable/equatable.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  List<OrderEntity> orders = [];
  final GetOrdersUsecase _getOrdersUsecase;
  final DeleteOrderUsecase _deleteOrderUsecase;

  OrdersCubit(
    this._getOrdersUsecase,
    this._deleteOrderUsecase,
  ) : super(OrdersInitial());

  Future<void> getOrders() async {
    emit(OrdersLoading());

    final res = await _getOrdersUsecase();

    res.fold(
      (failure) => emit(OrdersFailure(failure.code)),
      (ordersDb) {
        orders = [];
        orders.addAll(ordersDb);
        emit(OrdersSuccess(orders));
      },
    );
  }

  Future<void> removeOrder({required OrderEntity order}) async {
    emit(OrdersLoading());

    final res = await _deleteOrderUsecase(order: order);

    res.fold(
      (failure) => emit(OrdersFailure(failure.code)),
      (_) {
        orders.remove(order);
        emit(OrdersSuccess(orders));
      },
    );
  }
}
