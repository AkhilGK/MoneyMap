import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../homescreen/screens/bottom_nav/home_screen.dart';

class LoginProvider extends ChangeNotifier {
  bool loginSkipped = false; //to check login skipped
  void skipLogin(BuildContext ctx) {
    loginSkipped = true;
    Hive.box('onboarding_check').put('LoginSkipped', loginSkipped);
    Hive.box('onboarding_check')
        .put('userName', 'User'); //added user name to data base
    Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void saveLogin(BuildContext ctx, String userName) {
    loginSkipped = true;
    if (userName == '') {
      userName = 'User';
    }
    Hive.box('onboarding_check')
        .put('userName', userName); //added user name to data base
    Hive.box('onboarding_check').put('LoginSkipped',
        loginSkipped); //confirm the page wont appear again at restart
    Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
