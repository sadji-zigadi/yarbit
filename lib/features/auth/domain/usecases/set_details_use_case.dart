import '../repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';

class SetDetailsUsecase {
  final AuthRepository repository;

  SetDetailsUsecase(this.repository);

  Future<Either<Failure, Unit>> call({
    required String wilaya,
    required String commune,
    required String phoneNum,
  }) async {
    return await repository.setDetails(
      wilaya: wilaya,
      commune: commune,
      phoneNum: phoneNum,
    );
  }
}
