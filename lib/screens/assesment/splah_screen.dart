import 'dart:async';
import 'package:duo_clone/screens/assesment/tryscreen.dart';
import 'package:flutter/material.dart';
// import 'package:duo_clone/screens/screen1.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5),
      navigateToHomeScreen
    );
  }

  void navigateToHomeScreen() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ScreenTry()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex:2),
            Lottie.asset(
              'assets/animation/animation.json',
              width: 200,
              height: 200,
            ),
            const  Spacer(),
            const Text(
              "LanguageMaster",
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontFamily: 'Jost',
                fontWeight: FontWeight.bold
              ),
            ),
            const Spacer(flex: 3,)
          ],
        ),
      ),
    );
  }
}