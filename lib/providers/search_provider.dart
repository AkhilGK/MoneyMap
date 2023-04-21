import 'package:flutter/cupertino.dart';

class SearchProvider extends ChangeNotifier {
  String? dropdownValue;
  DateTime? startDate;
  DateTime? endDate;
  String query = '';
  dropDownfun(String newValue) {
    dropdownValue = newValue;
    notifyListeners();
  }

  customDateApply(DateTime startD, DateTime endD) {
    startDate = startD;
    endDate = endD;
    notifyListeners();
  }

  customDateCancel() {
    startDate = null;
    endDate = null;
    notifyListeners();
  }

  queryfun(String value) {
    query = value;
    notifyListeners();
  }
}
