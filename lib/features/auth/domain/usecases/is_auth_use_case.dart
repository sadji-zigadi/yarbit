import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';

class IsAuthUseCase {
  final AuthRepository repository;

  IsAuthUseCase(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.isAuth();
  }
}
