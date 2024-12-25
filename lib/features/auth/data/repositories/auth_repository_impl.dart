import 'dart:io';

import '../models/client_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/utils/network_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remote;
  final AuthLocalDatasource _local;
  final NetworkInfo _networkInfo;

  AuthRepositoryImpl(
    this._remote,
    this._local,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, ClientModel>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final user = await _remote.signUp(
          name: name,
          email: email,
          password: password,
        );
        await _local.cacheUser(user);

        return Right(user);
      } on FirebaseAuthException catch (e) {
        return Left(ServerFailure(e.code));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, ClientModel>> logIn({
    required String email,
    required String password,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final user = await _remote.logIn(
          email: email,
          password: password,
        );
        await _local.cacheUser(user);

        return Right(user);
      } on FirebaseAuthException catch (e) {
        return Left(ServerFailure(e.code));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> setDetails({
    required String wilaya,
    required String commune,
    required String phoneNum,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remote.setDetails(
          wilaya: wilaya,
          commune: commune,
          phoneNum: phoneNum,
        );
        await _local.cacheDetails(
          wilaya: wilaya,
          commune: commune,
          phoneNum: phoneNum,
        );

        return const Right(unit);
      } on FirebaseAuthException catch (e) {
        return Left(ServerFailure(e.code));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> forgetPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        await _remote.forgetPassword(email: email);
        return const Right(unit);
      } on FirebaseAuthException catch (e) {
        return Left(ServerFailure(e.code));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isAuth() async {
    try {
      final bool user = await _local.isAuth();
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    if (await _networkInfo.isConnected) {
      try {
        await _remote.signOut();
        await _local.deleteCache();
        return const Right(unit);
      } on FirebaseAuthException catch (e) {
        return Left(ServerFailure(e.code));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, ClientModel>> getProfileInfo() async {
    try {
      final user = await _local.getCachedUser();

      return Right(user);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> editProfileInfo({
    String? name,
    String? phoneNumber,
    String? email,
    String? password,
    File? image,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        if (image != null) {
          final pictureUrl = await _remote.editImage(image);
          await _local.cacheImage(pictureUrl);
        }

        if (name != null) {
          await _remote.editName(name);
          await _local.cacheName(name);
        }

        if (phoneNumber != null) {
          await _remote.editPhoneNumber(phoneNumber);
          await _local.cachePhoneNumber(phoneNumber);
        }

        // if (email != null) {
        //   await _remote.editEmail(email);
        //   await _local.cacheEmail(email);
        // }

        if (password != null) {
          await _remote.editPassword(password);
        }

        return const Right(unit);
      } on FirebaseAuthException catch (e) {
        return Left(ServerFailure(e.code));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
