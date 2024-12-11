import 'package:shared_preferences/shared_preferences.dart';

class UserLanguageService {
  static const String _languageKey = 'user_language';

  static Future<void> init() async {
    await SharedPreferences.getInstance();
  }

  static Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'en';
  }
}
