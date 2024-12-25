part of 'companies_cubit.dart';

sealed class CompaniesState extends Equatable {
  const CompaniesState();

  @override
  List<Object> get props => [];
}

final class CompaniesInitial extends CompaniesState {}

final class CompaniesLoading extends CompaniesState {}

final class CompaniesSuccess extends CompaniesState {
  final List<CompanyEntity> companies;

  const CompaniesSuccess(this.companies);

  @override
  List<Object> get props => [companies];
}

final class CompaniesFailure extends CompaniesState {
  final String message;

  const CompaniesFailure(this.message);

  @override
  List<Object> get props => [message];
}
