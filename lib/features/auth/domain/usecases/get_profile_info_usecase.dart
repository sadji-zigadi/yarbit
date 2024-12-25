import '../../../../core/failure/failure.dart';
import '../entities/client_entity.dart';
import '../repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetProfileInfoUsecase {
  final AuthRepository _repository;

  GetProfileInfoUsecase(this._repository);

  Future<Either<Failure, ClientEntity>> call() async =>
      await _repository.getProfileInfo();
}
