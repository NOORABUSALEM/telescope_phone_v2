import 'package:shared_preferences/shared_preferences.dart';

class UserThemeService {
  static const String _themeKey = 'user_theme';

  static Future<void> saveTheme(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, themeMode);
  }

  static Future<String> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeKey) ?? 'light';
  }
}
