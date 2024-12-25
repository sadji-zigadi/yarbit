import 'package:dartz/dartz.dart';

import '../../../failure/failure.dart';

abstract class LanguageRepository {
  Future<Either<Failure, Unit>> selectLanguage({required String languageCode});
  Future<Either<Failure, String>> getLanguage();
}
