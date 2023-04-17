import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymap/providers/onboarding_provider.dart';
import 'package:provider/provider.dart';
import '../../homescreen/screens/bottom_nav/home_screen.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 100,
      backgroundColor: const Color.fromARGB(249, 233, 222, 235),
      splash: "Assets/images/logo_wo_bg.png",
      nextScreen:
          Provider.of<OnboardingProvider>(context, listen: false).nextScreen(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
