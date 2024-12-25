import 'package:bloc/bloc.dart';
import '../../../../../core/system/domain/usecases/set_system_language_use_case.dart';
import '../../../../../core/utils/error_messages.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecases/set_details_use_case.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final SetSystemLanguageUsecase _setSystemLanguageUsecase;
  final SetDetailsUsecase _setDetailsUsecase;

  DetailsCubit(this._setDetailsUsecase, this._setSystemLanguageUsecase)
      : super(DetailsInitial());

  Future<void> setDetails(
    BuildContext context, {
    required String wilaya,
    required String commune,
    required String phoneNum,
    required String language,
  }) async {
    emit(DetailsLoading());

    final res = await _setDetailsUsecase(
      wilaya: wilaya,
      commune: commune,
      phoneNum: phoneNum,
    );

    final lang = await _setSystemLanguageUsecase(language: language);

    res.fold(
      (failure) {
        emit(DetailsFailure(errorMsg(context, failure: failure)));
      },
      (_) => lang.fold(
        (failure) => emit(DetailsFailure(errorMsg(context, failure: failure))),
        (_) => emit(DetailsSuccess()),
      ),
    );
  }
}
