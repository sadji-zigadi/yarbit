import 'package:bloc/bloc.dart';
import '../../../../../core/utils/error_messages.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecases/forget_password_use_case.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  ForgetPasswordCubit(this.forgetPasswordUseCase)
      : super(ForgetPasswordInitial());

  Future<void> forgetPassword(BuildContext context,
      {required String email}) async {
    emit(ForgetPasswordLoading());

    final response = await forgetPasswordUseCase(email);

    emit(response.fold(
      (failure) => ForgetPasswordFailure(errorMsg(context, failure: failure)),
      (_) => ForgetPasswordSuccess(),
    ));
  }
}
