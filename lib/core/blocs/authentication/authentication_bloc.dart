import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/token.dart';
import '../../data/models/user.dart';
import '../../data/providers/local_storage.dart';
import '../../data/repositories/auth_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthRepository authRepository = AuthRepository();

  AuthenticationBloc()
      : super(const AuthenticationState(
            status: AuthenticationStatus.unauthenticated)) {
    on<AuthenticationLogin>(_onLoginHandler);
    on<AuthenticationLogout>(_onLogoutHandler);
    on<AuthenticationStatusChecked>(_onVerifyhandler);
  }

  void onLogin(String username, String password) {
    add(AuthenticationLogin(username, password));
  }

  Future<void> _onLoginHandler(
    AuthenticationLogin event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationState(
      status: AuthenticationStatus.authenticationInProgress,
    ));

    try {
      // Get from API
      final Token token = await authRepository.signIn(
        dni: event.username,
        password: event.password,
      );
      // Save in LocalStorage
      await LocalStorage()
          .saveSession(token.token)
          .whenComplete(() => emit(AuthenticationState(
                status: AuthenticationStatus.authenticated,
                user: User.userFromToken(token.token),
              )));
    } catch (e) {
      // TODO: En el AuthRepository agregar el manejo de errores, incluir DIO
      emit(const AuthenticationState(
        status: AuthenticationStatus.authenticationError,
      ));
    }
  }

  Future<void> _onLogoutHandler(
    AuthenticationLogout event,
    Emitter<AuthenticationState> emit,
  ) async {
    // Delete in LocalStorage
    await LocalStorage().deleteSession();

    // Emmit result
    emit(const AuthenticationState(
      status: AuthenticationStatus.unauthenticated,
    ));
  }

  Future<void> _onVerifyhandler(
    AuthenticationStatusChecked event,
    Emitter<AuthenticationState> emit,
  ) async {
    final User? user = await LocalStorage().getSession();
    if (user != null) {
      emit(AuthenticationState(
        status: AuthenticationStatus.authenticated,
        user: user,
      ));
    } else {
      emit(const AuthenticationState(
        status: AuthenticationStatus.unauthenticated,
      ));
    }
  }
}
