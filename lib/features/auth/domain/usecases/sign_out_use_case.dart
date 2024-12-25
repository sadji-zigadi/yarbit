import 'package:dartz/dartz.dart';

import '../../../../core/failure/failure.dart';
import '../repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<Either<Failure, Unit>> call() async => await repository.signOut();
}
