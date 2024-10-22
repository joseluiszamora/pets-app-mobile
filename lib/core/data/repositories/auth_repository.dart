import '../providers/auth_provider.dart';

class AuthRepository {
  final AuthProvider _authProvider = AuthProvider();

  Future signIn({required String dni, required String password}) =>
      _authProvider.signIn(dni: dni.trim(), password: password);

  Future<bool> generateEmailCode(String email, String dni, String phone) =>
      _authProvider.generateEmailCode(email, dni, phone);
}
