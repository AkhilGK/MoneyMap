import 'package:flutter/cupertino.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transaction_model.dart';
import '../add transactions/db_transactions/transactions_functions.dart';

ValueNotifier<List<TransactionModel>> showList = ValueNotifier([]);
List<String> dropItems = ['All transactions', 'Income', 'Expense'];
List<TransactionModel> listToDisplay =
    transactionNotifier.value; //take all value from main list
ValueNotifier<List<TransactionModel>> searchFunction(
    {required String queryString,
    required String transactionType,
    DateTime? startDate,
    DateTime? endDate}) {
  if (startDate == null && endDate == null) {
    if (transactionType == dropItems[0]) {
      showList.value = listToDisplay
          .where((element) =>
              element.categoryName
                  .toLowerCase()
                  .contains(queryString.toLowerCase()) ||
              element.name.toLowerCase().contains(queryString.toLowerCase()))
          .toList();
      showList.notifyListeners();
    } else if (transactionType == dropItems[1]) {
      showList.value = listToDisplay
          .where((element) =>
              element.isIncome == true &&
              (element.categoryName
                      .toLowerCase()
                      .contains(queryString.toLowerCase()) ||
                  element.name
                      .toLowerCase()
                      .contains(queryString.toLowerCase())))
          .toList();
      showList.notifyListeners();
    } else {
      showList.value = listToDisplay
          .where((element) =>
              element.isIncome == false &&
              (element.categoryName
                      .toLowerCase()
                      .contains(queryString.toLowerCase()) ||
                  element.name
                      .toLowerCase()
                      .contains(queryString.toLowerCase())))
          .toList();
      showList.notifyListeners();
    }
  }

  //with date range

  else {
    if (transactionType == dropItems[0]) {
      showList.value = listToDisplay
          .where((element) =>
              element.categoryName
                  .toLowerCase()
                  .contains(queryString.toLowerCase()) ||
              element.name.toLowerCase().contains(queryString.toLowerCase()))
          .where((element) =>
              element.date.isBefore(endDate!.add(const Duration(days: 1))) &&
              element.date
                  .isAfter(startDate!.subtract(const Duration(days: 1))))
          .toList();
      showList.notifyListeners();
    } else if (transactionType == dropItems[1]) {
      showList.value = listToDisplay
          .where((element) =>
              element.isIncome == true &&
              (element.categoryName
                      .toLowerCase()
                      .contains(queryString.toLowerCase()) ||
                  element.name
                      .toLowerCase()
                      .contains(queryString.toLowerCase())))
          .where((element) =>
              element.date.isBefore(endDate!.add(const Duration(days: 1))) &&
              element.date
                  .isAfter(startDate!.subtract(const Duration(days: 1))))
          .toList();
      showList.notifyListeners();
    } else {
      showList.value = listToDisplay
          .where((element) =>
              element.isIncome == false &&
              (element.categoryName
                      .toLowerCase()
                      .contains(queryString.toLowerCase()) ||
                  element.name
                      .toLowerCase()
                      .contains(queryString.toLowerCase())))
          .where((element) =>
              element.date.isBefore(endDate!) &&
              element.date.isAfter(startDate!))
          .toList();
      showList.notifyListeners();
    }
  }
  return showList;
}
