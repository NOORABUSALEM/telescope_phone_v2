import 'dart:async';
  import 'package:flutter/material.dart';
  import 'package:telescope_phone_v2/presentation/routers/app_routes.dart';

  class TimerWidget extends StatefulWidget {
    @override
    _TimerWidgetState createState() => _TimerWidgetState();
  }

  class _TimerWidgetState extends State<TimerWidget> {
    late Timer _timer;
    int _start = 90; // 1 minute and 30 seconds

    @override
    void initState() {
      super.initState();
      startTimer();
    }

    void startTimer() {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (_start == 0) {
          _timer.cancel();
          // Navigate to login screen
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        } else {
          setState(() {
            _start--;
          });
        }
      });
    }

    @override
    void dispose() {
      _timer.cancel();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      int minutes = _start ~/ 60;
      int seconds = _start % 60;
      return Text('$minutes:${seconds.toString().padLeft(2, '0')}');
    }
  }