import '../../../failure/failure.dart';
import '../repositories/language_repository.dart';
import 'package:dartz/dartz.dart';

class GetLanguageUseCase {
  final LanguageRepository language;

  GetLanguageUseCase(this.language);

  Future<Either<Failure, String>> call() async {
    return await language.getLanguage();
  }
}
