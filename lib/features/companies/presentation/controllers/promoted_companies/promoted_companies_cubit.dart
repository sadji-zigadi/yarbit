import 'package:bloc/bloc.dart';
import 'package:client/core/shared/entities/company_entity.dart';
import 'package:client/core/utils/error_messages.dart';
import 'package:client/features/companies/domain/usecases/get_promoted_companies_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'promoted_companies_state.dart';

class PromotedCompaniesCubit extends Cubit<PromotedCompaniesState> {
  final GetPromotedCompaniesUsecase _getPromotedCompaniesUsecase;

  PromotedCompaniesCubit(this._getPromotedCompaniesUsecase)
      : super(PromotedCompaniesInitial());

  Future<void> getPromotedCompanies(BuildContext context) async {
    emit(PromotedCompaniesLoading());

    final res = await _getPromotedCompaniesUsecase();

    res.fold(
      (failure) =>
          emit(PromotedCompaniesFailure(errorMsg(context, failure: failure))),
      (companies) => emit(PromotedCompaniesSuccess(companies)),
    );
  }
}
