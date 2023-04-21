import 'package:flutter/cupertino.dart';

class EditProvider extends ChangeNotifier {
  String? categorycontroller;
  TextEditingController datecontroller = TextEditingController();
  changeCategory(String value) {
    categorycontroller = value;
    notifyListeners();
  }

  pickDateFun(String date) {
    datecontroller.text = date;
    notifyListeners();
  }
}
