import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  static const String _themeKey = 'user_theme';

  ThemeCubit() : super(AppTheme.lightTheme()) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isDarkTheme = prefs.getBool(_themeKey);

    if (isDarkTheme != null && isDarkTheme) {
      emit(AppTheme.darkTheme());
    } else {
      emit(AppTheme.lightTheme());
    }
  }

  Future<void> _saveTheme(bool isDarkTheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDarkTheme);
  }

  void toggleTheme() {
    if (state.brightness == Brightness.light) {
      emit(AppTheme.darkTheme());
      _saveTheme(true);
    } else {
      emit(AppTheme.lightTheme());
      _saveTheme(false);
    }
  }
}
