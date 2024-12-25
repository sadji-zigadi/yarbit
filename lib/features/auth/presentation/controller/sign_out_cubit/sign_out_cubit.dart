import 'package:bloc/bloc.dart';
import '../../../../../core/utils/error_messages.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/usecases/sign_out_use_case.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final SignOutUseCase _signOutUseCase;
  SignOutCubit(this._signOutUseCase) : super(SignOutInitial());

  Future<void> signOut(BuildContext context) async {
    emit(SignOutLoading());

    final result = await _signOutUseCase();

    emit(result.fold(
      (failure) => SignOutFailure(errorMsg(context, failure: failure)),
      (_) => SignOutSuccess(),
    ));
  }
}
