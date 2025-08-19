import 'dart:async';

// import 'package:chat_bot_app/screen/chat_screen.dart';
import 'package:chat_bot_app/screen/dashboard_screen.dart';
import 'package:flutter/material.dart';

import '../utils/util_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icon/robot.png",
              height: 150,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Chat Bot",
              style: mTextStyle25(
                  fontWeight: FontWeight.bold, fontColor: Colors.orange),
            )
          ],
        ),
      ),
    );
  }
}
