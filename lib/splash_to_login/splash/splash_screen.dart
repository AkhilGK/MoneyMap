import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:moneymap/providers/onboarding_provider.dart';
import 'package:moneymap/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/category_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryProvider>(context, listen: false).predefCategory();
    Provider.of<CategoryProvider>(context, listen: false).refreshUI();
    Provider.of<TransactionProvider>(context, listen: false).alertUi();

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
