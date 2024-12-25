import 'package:client/core/shared/entities/company_entity.dart';

import '../../../../core/failure/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CompaniesRepository {
  Future<Either<Failure, List<CompanyEntity>>> getCompanies();
  Future<Either<Failure, List<CompanyEntity>>> getPromotedCompanies();
}
