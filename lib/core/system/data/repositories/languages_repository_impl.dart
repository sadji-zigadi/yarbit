import '../../../failure/failure.dart';
import '../datasources/language_local_datasource.dart';
import '../../domain/repositories/language_repository.dart';
import 'package:dartz/dartz.dart';

class LanguagesRepositoryImpl implements LanguageRepository {
  final LanguageLocalDatasource _local;

  LanguagesRepositoryImpl(this._local);

  @override
  Future<Either<Failure, Unit>> selectLanguage(
      {required String languageCode}) async {
    try {
      await _local.saveLanguage(languageCode);

      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getLanguage() async {
    try {
      final language = await _local.loadLanguage();
      return Right(language);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
