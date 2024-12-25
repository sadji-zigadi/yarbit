import 'package:client/core/shared/entities/company_entity.dart';

import '../../../../core/failure/failure.dart';
import '../repositories/companies_repository.dart';
import 'package:dartz/dartz.dart';

class GetCompaniesUsecase {
  final CompaniesRepository _repository;

  GetCompaniesUsecase(this._repository);

  Future<Either<Failure, List<CompanyEntity>>> call() async =>
      await _repository.getCompanies();
}
