import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../entities/client_entity.dart';
import '../repositories/auth_repository.dart';

class LogInUseCase {
  final AuthRepository _authRepository;

  LogInUseCase(this._authRepository);

  Future<Either<Failure, ClientEntity>> call({
    required String email,
    required String password,
  }) async =>
      await _authRepository.logIn(
        email: email,
        password: password,
      );
}
