

import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/user_model.dart';

class UserService {
  static const String _userKey = 'user';

  // Save the User object to SharedPreferences
  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = user.toMap(); // Convert User to a Map
    prefs.setString(_userKey, userJson.toString()); // Save as a string
  }

  // Get the User object from SharedPreferences
  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(_userKey);
    if (userJson != null) {
      // Convert the string back to a User object
      Map<String, String> userMap = Map.fromEntries(
        userJson.substring(1, userJson.length - 1).split(',').map(
              (e) => MapEntry(e.split(':')[0].trim(), e.split(':')[1].trim()),
        ),
      );
      return User.fromMap(userMap); // Convert to User object
    }
    return null;
  }

  // Clear the User object from SharedPreferences
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // Save individual fields
  Future<void> saveUserName(String userName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', userName);
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  Future<void> saveUserEmail(String userEmail) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', userEmail);
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail');
  }

  Future<void> saveRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
  }

  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('role');
  }

  Future<void> saveDepartment(String department) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('department', department);
  }

  Future<String?> getDepartment() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('department');
  }

  Future<void> saveJobNumber(String jobNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jobNum', jobNumber);
  }

  Future<String?> getJobNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jobNum');
  }

  // Clear individual fields
  Future<void> clearUserName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
  }

  Future<void> clearUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userEmail');
  }

  Future<void> clearRole() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('role');
  }

  Future<void> clearDepartment() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('department');
  }

  Future<void> clearJobNumber() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jobNum');
  }
}