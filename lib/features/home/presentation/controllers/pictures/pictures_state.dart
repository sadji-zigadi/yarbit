part of 'pictures_cubit.dart';

sealed class PicturesState extends Equatable {
  const PicturesState();

  @override
  List<Object> get props => [];
}

final class PicturesInitial extends PicturesState {}

final class PicturesLoading extends PicturesState {}

final class PicturesSuccess extends PicturesState {
  final List<String> pictures;

  const PicturesSuccess(this.pictures);

  @override
  List<Object> get props => [pictures];
}

final class PicturesFailure extends PicturesState {
  final String message;

  const PicturesFailure(this.message);

  @override
  List<Object> get props => [message];
}
