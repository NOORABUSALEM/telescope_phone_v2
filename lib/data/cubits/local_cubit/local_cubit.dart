import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_state.dart';
import 'dart:ui';

class LocaleCubit extends Cubit<LocalState> {
  static const String _languageKey = 'user_language';

  LocaleCubit() : super(SelectedLocale(Locale('en'))) {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString(_languageKey);

    if (savedLanguage != null && savedLanguage == 'ar') {
      emit(SelectedLocale(Locale('ar')));
    } else {
      emit(SelectedLocale(Locale('en')));
    }
  }

  Future<void> _saveLocale(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  // Switch to Arabic
  void toArabic() {
    _saveLocale('ar'); // Save preference
    emit(SelectedLocale(Locale('ar')));
  }

  // Switch to English
  void toEnglish() {
    _saveLocale('en'); // Save preference
    emit(SelectedLocale(Locale('en')));
  }
}
