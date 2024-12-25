import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:client/core/utils/error_messages.dart';
import 'package:client/features/auth/domain/usecases/edit_profile_info_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'edit_profile_info_state.dart';

class EditProfileInfoCubit extends Cubit<EditProfileInfoState> {
  final EditProfileInfoUseCase _editProfileInfoUseCase;

  EditProfileInfoCubit(this._editProfileInfoUseCase)
      : super(EditProfileInfoInitial());

  Future<void> editProfileInfo(
    BuildContext context, {
    String? name,
    String? phoneNum,
    String? email,
    String? password,
    File? image,
  }) async {
    emit(EditProfileInfoLoading());

    final res = await _editProfileInfoUseCase(
      email: email,
      name: name,
      password: password,
      phoneNumber: phoneNum,
      image: image,
    );

    res.fold(
      (failure) =>
          emit(EditProfileInfoFailure(errorMsg(context, failure: failure))),
      (_) => emit(EditProfileInfoSuccess()),
    );
  }
}
