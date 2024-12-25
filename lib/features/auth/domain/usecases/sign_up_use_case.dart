import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../entities/client_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  Future<Either<Failure, ClientEntity>> call({
    required String name,
    required String email,
    required String password,
  }) async =>
      await _authRepository.signUp(
        name: name,
        email: email,
        password: password,
      );
}
