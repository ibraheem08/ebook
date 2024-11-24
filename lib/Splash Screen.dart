import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ebook/user/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class splash extends StatefulWidget {
  @override
  State<splash> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<splash> {
  get splash => null;

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 4500,
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset(
                "assets/Animation/Animation - 1710575901426.json"),
          ),
        ],
      ),
      nextScreen: const WelcomeScreen(),
      splashIconSize: 400,
      // splashTransitionDuration: const Duration(milliseconds: 4000),
      backgroundColor: Color.fromARGB(174, 230, 91, 79),
    );
  }
}
