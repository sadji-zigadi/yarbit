part of 'profile_info_cubit.dart';

sealed class ProfileInfoState extends Equatable {
  const ProfileInfoState();

  @override
  List<Object> get props => [];
}

final class ProfileInfoInitial extends ProfileInfoState {}

final class ProfileInfoLoading extends ProfileInfoState {}

final class ProfileInfoSuccess extends ProfileInfoState {
  final ClientEntity user;

  const ProfileInfoSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class ProfileInfoFailure extends ProfileInfoState {
  final String message;

  const ProfileInfoFailure(this.message);

  @override
  List<Object> get props => [message];
}
