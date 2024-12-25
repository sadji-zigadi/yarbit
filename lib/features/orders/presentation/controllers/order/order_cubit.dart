import 'package:bloc/bloc.dart';
import 'package:client/features/orders/domain/entities/order_entity.dart';
import '../../../domain/usecases/create_order_usecase.dart';
import '../../../../../core/utils/error_messages.dart';
import 'package:flutter/cupertino.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final CreateOrderUsecase _createOrderUsecase;
  OrderCubit(this._createOrderUsecase) : super(OrderInitial());

  Future<void> createOrder(
    BuildContext context, {
    required String companyId,
    required String companyName,
    required List<dynamic> companyServices,
    required String companyPhoneNumber,
    required String companyLogoUrl,
  }) async {
    emit(OrderLoading());

    final order = OrderEntity(
      companyId: companyId,
      companyName: companyName,
      companyServices: companyServices,
      companyPhoneNumber: companyPhoneNumber,
      companyPictureUrl: companyLogoUrl,
      date: DateTime.now(),
    );

    final res = await _createOrderUsecase(order: order);

    emit(res.fold(
      (failure) => OrderFailure(errorMsg(context, failure: failure)),
      (_) => OrderSuccess(),
    ));
  }
}
