import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class ForgetPasswordUseCase {
  final AuthRepository repository;

  ForgetPasswordUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String email) async {
    return await repository.forgetPassword(email);
  }
}
