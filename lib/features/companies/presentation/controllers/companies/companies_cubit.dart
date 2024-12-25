import 'package:bloc/bloc.dart';
import 'package:client/core/shared/entities/company_entity.dart';
import '../../../../../core/utils/error_messages.dart';
import '../../../domain/usecases/get_companies_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  final GetCompaniesUsecase _getCompaniesUsecase;

  CompaniesCubit(this._getCompaniesUsecase) : super(CompaniesInitial());

  Future<void> getCompanies(BuildContext context) async {
    emit(CompaniesLoading());

    final res = await _getCompaniesUsecase();

    res.fold(
      (failure) => emit(CompaniesFailure(errorMsg(context, failure: failure))),
      (companies) => emit(CompaniesSuccess(companies)),
    );
  }
}
