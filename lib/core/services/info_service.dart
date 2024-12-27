import 'package:shared_preferences/shared_preferences.dart';

class InfoService {
  static const String _dateTime = 'date_time';

  Future<void> saveDate(String date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dateTime, date); // Save the string as is
  }

  Future<String?> getDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_dateTime);
  }
}
