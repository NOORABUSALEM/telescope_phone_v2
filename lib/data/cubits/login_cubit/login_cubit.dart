import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telescope_phone_v2/core/services/user_service.dart';
import '../../../core/services/auth_service.dart';
import '../../models/user_model.dart';
import '../../repos/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  final AuthService _authService = AuthService(); // AuthService for saving token
  final UserService _userService = UserService();

  LoginCubit(this._authRepository) : super(LoginInitial());

  void login(String email, String password) async {
    print("Login started");
    emit(LoginLoading());

    try {
      final result = await _authRepository.login(email, password);
      if (result != null) {
        User user = result['user'];
        String token = result['token'];

        await _userService.saveUserName(user.name.toString());
        await _userService.saveUserEmail(user.email.toString());
        await _userService.saveRole(user.role.toString());
        await _authService.saveToken(token);

        print('Login success: User name: ${user.name}, Token: $token');

        emit(LoginSuccess(user));
      } else {
        print('Login failed: result is null');
        emit(LoginFailure('Login failed. Please try again.'));
      }
    } catch (e) {
      print('Login failed with error: $e');
      String errorMessage = e.toString().replaceAll('Exception:', '').trim();

      emit(LoginFailure(errorMessage));
    }
  }


  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await _authService.clearToken();
    await prefs.clear();
    int min = 5 ;
    _authRepository.logout(min);
  }
}

