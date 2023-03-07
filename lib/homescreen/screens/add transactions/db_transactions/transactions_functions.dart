import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transaction_model.dart';

ValueNotifier<List<TransactionModel>> transactionNotifier = ValueNotifier([]);

//function add

Future<void> insertTransactions(TransactionModel transaction) async {
  final transactionDb = await Hive.openBox<TransactionModel>('transaction_db');
  await transactionDb.add(transaction);
  alertUi();
}

//function to getvalues

Future<List<TransactionModel>> getTransations() async {
  final transactionDb = await Hive.openBox<TransactionModel>('transaction_db');
  return transactionDb.values.toList();
}

//functions

Future<void> alertUi() async {
  final allTransactions = await getTransations();
  allTransactions.sort(
    (first, second) => second.date.compareTo(first.date),
  );
  transactionNotifier.value.clear();
  transactionNotifier.value.addAll(allTransactions);

  transactionNotifier.notifyListeners();
}

//delete

Future<void> deleteTransaction(String transId) async {
  final transactionDb = await Hive.openBox<TransactionModel>('transaction_db');
  await transactionDb.delete(transId);
  alertUi();
}
