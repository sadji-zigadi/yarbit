import 'package:bloc/bloc.dart';
import '../../../../../core/utils/error_messages.dart';
import '../../../domain/entities/client_entity.dart';
import '../../../domain/usecases/get_profile_info_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  final GetProfileInfoUsecase _getProfileInfoUsecase;

  ProfileInfoCubit(this._getProfileInfoUsecase) : super(ProfileInfoInitial());

  Future<void> getProfileInfo(BuildContext context) async {
    emit(ProfileInfoLoading());

    final res = await _getProfileInfoUsecase();

    res.fold(
      (failure) =>
          emit(ProfileInfoFailure(errorMsg(context, failure: failure))),
      (user) => emit(ProfileInfoSuccess(user)),
    );
  }
}
