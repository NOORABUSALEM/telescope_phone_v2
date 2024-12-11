import 'package:flutter/material.dart';

import '../screens/home/home_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = "/splash";
  static const String login = "/login";
  static const String home = "/home";
  // static const String dailyKpi = "/dailyKpi";
  // static const String monthlyKpi = "/monthlyKpi";
  // static const String aboutKpi = "/aboutKpi";
  // static const String kpiSettings = "/kpiSettings";
  // static const String allKpis = "/allKpis";

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      login: (context) => LoginScreen(),
      home: (context) => const HomeScreen(),
      // dailyKpi: (context) => const DailyDetails(),
      // monthlyKpi: (context) => const MonthlyKpisView(),
      // aboutKpi: (context) => AboutKpi(),
      // kpiSettings: (context) => KpiSettings(),
      // allKpis: (context) => AllKpis(),
    };
  }
}
