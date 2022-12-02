import 'dart:convert';
import 'package:world_cup/resources/api.dart';

class AuthService {
  AuthService._();
  static final instance = AuthService._();

  Future<String?> login(String? email, String? password) async {
    final data = json.encode({'email': email, 'password': password});
    try {
      final response = await Api().authDio.post(
            'auth/login',
            data: data,
          );
      return response.data['access_token'];
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      final data =
          json.encode({'oldPassword': oldPassword, 'newPassword': newPassword});
      final response =
          await Api().authDio.post('auth/change-password', data: data);
      return true;
    } catch (e) {
      rethrow;
    }
  }
}
