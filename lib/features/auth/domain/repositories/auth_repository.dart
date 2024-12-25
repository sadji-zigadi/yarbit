import 'dart:io';

import '../../../../core/failure/failure.dart';
import '../entities/client_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, ClientEntity>> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, ClientEntity>> logIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> setDetails({
    required String wilaya,
    required String commune,
    required String phoneNum,
  });

  Future<Either<Failure, Unit>> forgetPassword(String email);

  Future<Either<Failure, bool>> isAuth();

  Future<Either<Failure, Unit>> signOut();

  Future<Either<Failure, ClientEntity>> getProfileInfo();

  Future<Either<Failure, Unit>> editProfileInfo({
    String? name,
    String? phoneNumber,
    String? email,
    String? password,
    File? image,
  });
}
