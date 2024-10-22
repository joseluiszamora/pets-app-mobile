import 'package:dio/dio.dart';
import 'package:pets_app_mobile/core/data/api_client.dart';

import '../models/token.dart';

class AuthProvider {
  final ApiClient _apiClient = ApiClient();

  Future<Token?> signIn({required String dni, required String password}) async {
    Response response = await _apiClient.dio
        .post("/api/v1/auth/sign-in", data: {"dni": dni, "password": password});
    return Token.fromJson(response.data["data"]);
  }

  Future<bool> generateEmailCode(String email, String dni, String phone) async {
    final response = await _apiClient.dio.post("/api/v1/auth/generate-code",
        data: {"email": email.trim(), "dni": dni.trim(), "phone": phone.trim()},
        options: Options(headers: {"requiresToken": false}));

    if (response.statusCode == 200) {
      return false;
    }

    return true;
  }
}
