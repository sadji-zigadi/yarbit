part of 'sign_up_cubit.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();
}

final class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

final class SignUpLoading extends SignUpState {
  @override
  List<Object?> get props => [];
}

final class SignUpSuccess extends SignUpState {
  final ClientEntity user;

  const SignUpSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

final class SignUpFailure extends SignUpState {
  final String message;
  final String? code;

  const SignUpFailure(this.message, [this.code]);

  @override
  List<Object?> get props => [message];
}

final class PasswordError extends SignUpState {
  final String? message;

  const PasswordError([this.message]);

  @override
  List<Object?> get props => [message];
}

final class EmailError extends SignUpState {
  final String? message;

  const EmailError([this.message]);

  @override
  List<Object?> get props => [message];
}
