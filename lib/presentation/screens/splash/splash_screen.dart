import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routers/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('user_token');

    if (token != null) {
      // If token exists, navigate to the home screen
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      // If no token, navigate to the login screen
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(image: AssetImage('assets/images/Asset12.png')),
      ),
    );
  }
}
