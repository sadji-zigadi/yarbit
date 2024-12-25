part of 'edit_profile_info_cubit.dart';

sealed class EditProfileInfoState extends Equatable {
  const EditProfileInfoState();

  @override
  List<Object> get props => [];
}

final class EditProfileInfoInitial extends EditProfileInfoState {}

final class EditProfileInfoLoading extends EditProfileInfoState {}

final class EditProfileInfoSuccess extends EditProfileInfoState {}

final class EditProfileInfoFailure extends EditProfileInfoState {
  final String message;

  const EditProfileInfoFailure(this.message);

  @override
  List<Object> get props => [message];
}
