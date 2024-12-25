part of 'promoted_companies_cubit.dart';

sealed class PromotedCompaniesState extends Equatable {
  const PromotedCompaniesState();

  @override
  List<Object> get props => [];
}

final class PromotedCompaniesInitial extends PromotedCompaniesState {}

final class PromotedCompaniesLoading extends PromotedCompaniesState {}

final class PromotedCompaniesSuccess extends PromotedCompaniesState {
  final List<CompanyEntity> companies;

  const PromotedCompaniesSuccess(this.companies);

  @override
  List<Object> get props => [companies];
}

final class PromotedCompaniesFailure extends PromotedCompaniesState {
  final String message;

  const PromotedCompaniesFailure(this.message);

  @override
  List<Object> get props => [message];
}
