part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationLogin extends AuthenticationEvent {
  final String username;
  final String password;

  const AuthenticationLogin(this.username, this.password);
}

class AuthenticationLogout extends AuthenticationEvent {}

class AuthenticationStatusChecked extends AuthenticationEvent {}
