import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/error_messages.dart';
import '../../../domain/entities/client_entity.dart';
import '../../../domain/usecases/log_in_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LogInUseCase logInUseCase;

  LoginCubit(this.logInUseCase) : super(LoginInitial());

  Future<void> logIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    emit(LogInLoading());

    final res = await logInUseCase(
      email: email,
      password: password,
    );

    res.fold(
      (failure) {
        emit(LoginFailure(errorMsg(context, failure: failure)));

        if (failure.code == 'invalid-credential') {
          emit(InvalidCredential());
        } else if (failure.code == 'invalid-email') {
          emit(EmailError());
        } else if (failure.code == 'password-error') {
          emit(PasswordError());
        }
      },
      (user) => emit(LoginSuccess(user)),
    );
  }

  void emailError() {
    emit(EmailError());
  }

  void passwordError() {
    emit(PasswordError());
  }

  void invalideCredential() {
    emit(InvalidCredential());
  }
}
