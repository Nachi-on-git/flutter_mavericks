// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mavericks/models/timehseet.dart';
import 'package:flutter_mavericks/screens/login_screen.dart';
import 'package:flutter_mavericks/screens/timesheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dashboard.dart';
import 'onboarding_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  Future<void> destination() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isVisitedOnboarding') == true) {
      if (prefs.getString('token') != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Dashboard(),
        ));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnboardingView(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () => destination());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/splash_logo.png",
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
