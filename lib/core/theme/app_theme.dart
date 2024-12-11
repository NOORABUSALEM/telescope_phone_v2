import 'package:flutter/material.dart';
import '../styles/color_constants.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      scaffoldBackgroundColor: AppColors.backgroundColor,
      textTheme: getTextTheme("ar"),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.secondary,
            textStyle: const TextStyle(
                fontFamily: 'NotoKufi',
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.secondary,
        ),
      ),
      appBarTheme: const AppBarTheme(
          color: AppColors.backgroundColor,
          titleTextStyle: TextStyle(
              fontFamily: 'NotoKufi',
              fontSize: 18,
              color: AppColors.lightTextColor)),
      drawerTheme:
          const DrawerThemeData(backgroundColor: AppColors.backgroundColor),
      listTileTheme: const ListTileThemeData(iconColor: AppColors.greyColor),
      cardTheme: const CardTheme(color: AppColors.lightCardColor),
      tabBarTheme: const TabBarTheme(
        labelStyle: TextStyle(
            fontFamily: 'NotoKufi', fontSize: 16, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'NotoKufi',
          fontSize: 14,
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      scaffoldBackgroundColor: AppColors.darkBackgroundColor,
      textTheme: getTextTheme("ar", isDarkTheme: true),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.primary,
            textStyle: const TextStyle(
                fontFamily: 'NotoKufi',
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.secondary, // Text color in light theme
        ),
      ),
      appBarTheme: const AppBarTheme(
          color: AppColors.darkBackgroundColor,
          titleTextStyle: TextStyle(fontFamily: 'NotoKufi', fontSize: 18)),
      drawerTheme:
          const DrawerThemeData(backgroundColor: AppColors.darkBackgroundColor),
      listTileTheme: const ListTileThemeData(iconColor: AppColors.secondary),
      cardTheme: CardTheme(color: AppColors.darkCardColor),
      tabBarTheme: const TabBarTheme(
        labelStyle: TextStyle(
            fontFamily: 'NotoKufi', fontSize: 16, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'NotoKufi',
          fontSize: 14,
        ),
      ),
    );
  }

  static TextTheme getTextTheme(String languageCode,
      {bool isDarkTheme = false}) {
    final textColor =
        isDarkTheme ? AppColors.darkTextColor : AppColors.lightTextColor;
    final labelColor =
        isDarkTheme ? AppColors.lightGreyColor : AppColors.labelGreyColor;

    if (languageCode == 'ar') {
      return TextTheme(
        bodyMedium: TextStyle(
          fontFamily: 'NotoKufi',
          color: textColor,
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          fontFamily: 'NotoKufi',
          color: labelColor,
          fontSize: 16,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'NotoKufi',
          color: textColor,
          fontSize: 18,
        ),
        titleMedium:
            TextStyle(fontFamily: 'NotoKufi', color: textColor, fontSize: 18),
        titleLarge: TextStyle(
            fontFamily: 'NotoKufi',
            color: textColor,
            fontSize: 24,
            fontWeight: FontWeight.bold),
      );
    } else {
      return TextTheme(
        titleMedium:
            TextStyle(fontFamily: 'Inter', color: textColor, fontSize: 18),
        bodyLarge:
            TextStyle(fontFamily: 'Inter', color: textColor, fontSize: 24),
        titleSmall:
            TextStyle(fontFamily: 'Inter', color: textColor, fontSize: 14),
      );
    }
  }
}
