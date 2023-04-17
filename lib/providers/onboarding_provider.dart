import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../homescreen/screens/bottom_nav/home_screen.dart';
import '../splash_to_login/onboarding/onboarding_screen.dart';
import '../splash_to_login/userl_login/user_login.dart';

class OnboardingProvider extends ChangeNotifier {
  bool onboardingSkipped = false; //to check onboardings skipped

  Widget nextScreen() {
    bool? checkSkipped = Hive.box('onboarding_check')
        .get('is_skipped'); //if once skipped the value will be true
    bool? checkLoginSkipped = Hive.box('onboarding_check')
        .get('LoginSkipped'); //if once skipped the value will be true

    if (checkSkipped == true && checkLoginSkipped == true) {
      return HomeScreen();
    } else {
      return const OnboardingScreen();
    }
  }

  skipOnboarding(BuildContext ctx) {
    onboardingSkipped = true;
    Hive.box('onboarding_check').put('is_skipped', onboardingSkipped);

    //if onboarding skipped go to loginpage
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (context) {
          return UserLogin();
        },
      ),
    );
    notifyListeners();
  }
}
