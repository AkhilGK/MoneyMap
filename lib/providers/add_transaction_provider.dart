import 'package:flutter/cupertino.dart';

class AddtransactionProvider extends ChangeNotifier {
  String selectedIncomeCategory = "";
  String selectedExpenseCategory = "";

  TextEditingController dateinputExpense = TextEditingController();
  TextEditingController dateinputIncome = TextEditingController();

  incomeCategoryFun(String value) {
    selectedIncomeCategory = value;
    notifyListeners();
  }

  expenseCategoryFun(String value) {
    selectedExpenseCategory = value;
  }

  dateInExpense(String dateIn) {
    dateinputExpense.text = dateIn;
  }

  dateInIncome(String dateIn) {
    dateinputIncome.text = dateIn;
  }
}
