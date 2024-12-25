import 'package:bloc/bloc.dart';
import '../../../../../core/utils/error_messages.dart';
import '../../../domain/usecases/get_pictures_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'pictures_state.dart';

class PicturesCubit extends Cubit<PicturesState> {
  final GetPicturesUsecase _getPicturesUsecase;

  PicturesCubit(this._getPicturesUsecase) : super(PicturesInitial());

  Future<void> getPictures(BuildContext context) async {
    emit(PicturesLoading());

    final res = await _getPicturesUsecase();

    res.fold(
      (failure) => emit(PicturesFailure(errorMsg(context, failure: failure))),
      (pictures) => emit(PicturesSuccess(pictures)),
    );
  }
}
