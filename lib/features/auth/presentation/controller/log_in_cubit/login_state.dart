part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();
}

final class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

final class LogInLoading extends LoginState {
  @override
  List<Object?> get props => [];
}

final class LoginSuccess extends LoginState {
  final ClientEntity user;

  const LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

final class LoginFailure extends LoginState {
  final String message;
  final String? code;

  const LoginFailure(this.message, [this.code]);

  @override
  List<Object?> get props => [message];
}

final class EmailError extends LoginState {
  @override
  List<Object?> get props => [];
}

final class PasswordError extends LoginState {
  @override
  List<Object?> get props => [];
}

final class InvalidCredential extends LoginState {
  @override
  List<Object?> get props => [];
}
