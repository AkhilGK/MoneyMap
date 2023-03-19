import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../homescreen/screens/bottom_nav/home_screen.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 100,
      backgroundColor: const Color.fromARGB(249, 233, 222, 235),
      splash: "Assets/images/moneyMapLogo.png",
      nextScreen: nextScreen(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }

  Widget nextScreen() {
    bool? checkSkipped = Hive.box('onboarding_check')
        .get('is_skipped'); //if once skipped the value will be true
    bool? checkLoginSkipped = Hive.box('onboarding_check')
        .get('LoginSkipped'); //if once skipped the value will be true

    // return OnboardingScreen();

    if (checkSkipped == true && checkLoginSkipped == true) {
      return HomeScreen();
    } else {
      return const OnboardingScreen();
    }
  }
}
