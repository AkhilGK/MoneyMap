import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FirstScreenProvider extends ChangeNotifier {
  String userNameFromDB = Hive.box('onboarding_check').get('userName');
  void changeName(String name) {
    Hive.box('onboarding_check').put('userName', name);
    userNameFromDB = Hive.box('onboarding_check').get('userName');
    notifyListeners();
  }
}
