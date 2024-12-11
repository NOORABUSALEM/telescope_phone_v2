
import '../../core/services/auth_service.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';

class AuthRepository {
  final AuthProvider _authProvider;
  final AuthService _authService;

  AuthRepository({
    required AuthProvider authProvider,
    required AuthService authService,
  })  : _authProvider = authProvider,
        _authService = authService;

  // Login method
  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await _authProvider.login(email, password);

      if (response.statusCode == 200 && response.data != null) {
        final token = response.data['token'];
        final user = User.fromJson(response.data['user']);

        // Save token locally
        await _authService.saveToken(token);

        return {'user': user, 'token': token};
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Logout method
  Future<void> logout() async {
    await _authService.clearToken();
  }

  // Check login status
  Future<bool> isLoggedIn() async {
    final token = await _authService.getToken();
    return token != null;
  }
}
