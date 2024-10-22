part of 'authentication_bloc.dart';

enum AuthenticationStatus {
  unauthenticated,
  authenticated,
  authenticationInProgress,
  authenticationStatusChecked,
  authenticationError,
  authenticationUserError,
}

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User user;

  const AuthenticationState({
    this.status = AuthenticationStatus.unauthenticated,
    this.user = User.empty,
  });

  @override
  List<Object> get props => [status, user];
}
