import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/constants.dart';

class AuthProvider {
  final Dio _dio;

  AuthProvider(this._dio) {
    _dio.options.baseUrl = ApiConstants.baseUrl;

  }

  // Login API call
  Future<Response> login(String email, String password) async {
    final data = {'email': email, 'password': password};
    return await _dio.post(ApiConstants.loginEndpoint, data: data);
  }


  Future<void> logout(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('user_token');
    final response = await _dio.post(
      ApiConstants.logoutEndpoint,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: jsonEncode({"duration": minutes}),

    );

    if (response.statusCode != 200) {
      throw Exception('Logout failed');
    }
  }
}

