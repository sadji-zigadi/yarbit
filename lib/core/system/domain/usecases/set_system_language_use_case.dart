import '../../../failure/failure.dart';
import '../repositories/language_repository.dart';
import 'package:dartz/dartz.dart';

class SetSystemLanguageUsecase {
  final LanguageRepository repository;

  SetSystemLanguageUsecase(this.repository);

  Future<Either<Failure, Unit>> call({required String language}) async {
    return repository.selectLanguage(languageCode: language);
  }
}
