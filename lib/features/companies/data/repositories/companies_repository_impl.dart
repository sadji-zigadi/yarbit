import 'package:client/core/shared/entities/company_entity.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/utils/network_info.dart';
import '../datasources/companies_remote_datasource.dart';
import '../../domain/repositories/companies_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class CompaniesRepositoryImpl implements CompaniesRepository {
  final CompaniesRemoteDatasource _remote;
  final NetworkInfo _networkInfo;

  CompaniesRepositoryImpl(this._remote, this._networkInfo);

  @override
  Future<Either<Failure, List<CompanyEntity>>> getCompanies() async {
    if (await _networkInfo.isConnected) {
      try {
        final List<CompanyEntity> companies = await _remote.getCompanies();

        return Right(companies);
      } on FirebaseException catch (e) {
        return Left(ServerFailure(e.code));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<CompanyEntity>>> getPromotedCompanies() async {
    if (await _networkInfo.isConnected) {
      try {
        final companies = await _remote.getPromotedCompanies();

        return Right(companies);
      } on FirebaseException catch (e) {
        return Left(ServerFailure(e.code));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
