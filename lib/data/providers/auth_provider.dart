import 'package:dio/dio.dart';

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

  // // Logout API call (optional)
  // Future<Response> logout() async {
  //   return await _dio.post(ApiConstants.logoutEndpoint);
  // }

}
