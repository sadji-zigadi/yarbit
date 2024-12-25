import 'dart:io';

import 'package:client/core/failure/failure.dart';
import 'package:client/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class EditProfileInfoUseCase {
  final AuthRepository _repository;

  const EditProfileInfoUseCase(this._repository);

  Future<Either<Failure, Unit>> call({
    String? name,
    String? phoneNumber,
    String? email,
    String? password,
    File? image,
  }) async =>
      await _repository.editProfileInfo(
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        password: password,
        image: image,
      );
}
