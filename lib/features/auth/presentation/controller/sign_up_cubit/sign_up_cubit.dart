import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../../../../../core/utils/error_messages.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entities/client_entity.dart';
import '../../../domain/usecases/sign_up_use_case.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpCubit(this.signUpUseCase) : super(SignUpInitial());

  Future<void> signUp(
    BuildContext context, {
    required String name,
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());

    final res = await signUpUseCase(
      name: name,
      email: email,
      password: password,
    );

    res.fold(
      (failure) {
        emit(SignUpFailure(errorMsg(context, failure: failure)));

        if (failure.code == 'email-already-in-use' ||
            failure.code == 'invalid-email') {
          log(errorMsg(context, failure: failure));
          emit(EmailError(errorMsg(context, failure: failure)));
        } else if (failure.code == 'weak-password') {
          emit(PasswordError(errorMsg(context, failure: failure)));
        }
      },
      (user) => emit(SignUpSuccess(user)),
    );
  }

  void passwordError() {
    emit(const PasswordError());
  }
}
