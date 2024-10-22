import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pets_app_mobile/core/data/models/user.dart';

class LocalStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  static const sessionKey = 'session';

  Future<void> saveSession(String token) async {
    await storage.write(key: sessionKey, value: token);
  }

  Future<User?> getSession() async {
    final String? session = await storage.read(key: sessionKey);
    if (session != null) {
      return User.userFromToken(session);
    }
    return null;
  }

  Future<void> deleteSession() async {
    await storage.delete(key: sessionKey);
  }
}
