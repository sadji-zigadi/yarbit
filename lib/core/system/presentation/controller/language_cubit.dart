import 'package:bloc/bloc.dart';
import '../../domain/usecases/get_language_use_case.dart';
import '../../domain/usecases/set_system_language_use_case.dart';
import '../../../utils/error_messages.dart';
import 'package:flutter/material.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final SetSystemLanguageUsecase _setSystemLanguageUseCase;
  final GetLanguageUseCase _getLanguageUseCase;

  LanguageCubit(this._setSystemLanguageUseCase, this._getLanguageUseCase)
      : super(LanguageInitial());

  Future<void> selectLanguage(BuildContext context, String languageCode) async {
    emit(LanguageLoading());

    final res = await _setSystemLanguageUseCase(language: languageCode);

    res.fold(
      (failure) {
        emit(LanguageError(errorMsg(context, failure: failure)));
      },
      (_) {
        emit(LanguageChanged(languageCode));
      },
    );
  }

  Future<void> getLanguage(BuildContext context) async {
    emit(LanguageLoading());

    final res = await _getLanguageUseCase();

    res.fold(
      (failure) => emit(LanguageError(errorMsg(context, failure: failure))),
      (language) => emit(GetLanguageSuccess(language)),
    );
  }
}
