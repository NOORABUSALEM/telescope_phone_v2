
import 'package:dio/dio.dart';

import '../../core/services/auth_service.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';

class AuthRepository {
  final AuthProvider _authProvider;

  AuthRepository({
    required AuthProvider authProvider,
    required AuthService authService,
  })
      : _authProvider = authProvider;

  // Login method
  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await _authProvider.login(email, password);

      if (response.statusCode == 200 && response.data != null) {
        final token = response.data['token'];
        final user = User.fromJson(response.data['user']);

        return {'user': user, 'token': token};
      } else {
        // Handle non-200 responses
        final errorMessage = response.data?['message'] ?? 'Unknown error occurred';
        throw Exception(errorMessage);
      }
    } on DioError catch (dioError) {
      // Handle Dio-specific errors
      final errorMessage = dioError.response?.data?['message'] ??
          dioError.message ??
          'An error occurred';
      throw Exception(errorMessage);
    } catch (e) {
      // Handle other exceptions
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Logout method
  Future<void> logout(int minutes) async {
    try {
      await _authProvider.logout(minutes);
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }
}
