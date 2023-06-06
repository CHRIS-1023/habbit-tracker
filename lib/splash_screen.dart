import 'package:flutter/material.dart';
import 'package:habbit_tracker/const_widgets.dart';
import 'package:habbit_tracker/helpers.dart';
import 'package:habbit_tracker/home_page.dart';
import 'package:habbit_tracker/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isSignedIn = false;
  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        nextScreen(context, const HomePage());
      } else {
        nextScreen(context, const LogIn());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SplashScreen'),
      ),
    );
  }
}
