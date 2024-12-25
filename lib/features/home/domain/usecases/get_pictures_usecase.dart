import '../../../../core/failure/failure.dart';
import '../repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

class GetPicturesUsecase {
  final HomeRepository _repository;

  GetPicturesUsecase(this._repository);

  Future<Either<Failure, List<String>>> call() async =>
      await _repository.getPictures();
}
