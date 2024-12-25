import 'package:client/core/failure/failure.dart';
import 'package:client/core/shared/entities/company_entity.dart';
import 'package:client/features/companies/domain/repositories/companies_repository.dart';
import 'package:dartz/dartz.dart';

class GetPromotedCompaniesUsecase {
  final CompaniesRepository _repository;

  GetPromotedCompaniesUsecase(this._repository);

  Future<Either<Failure, List<CompanyEntity>>> call() async =>
      await _repository.getPromotedCompanies();
}
