part of 'language_cubit.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

final class LanguageLoading extends LanguageState {}

final class GetLanguageSuccess extends LanguageState {
  final String languageCode;

  GetLanguageSuccess(this.languageCode);
}

final class LanguageChanged extends LanguageState {
  final String languageCode;

  LanguageChanged(this.languageCode);
}

final class LanguageError extends LanguageState {
  final String message;

  LanguageError(this.message);
}
