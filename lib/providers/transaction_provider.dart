import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

import '../homescreen/screens/add transactions/db_transactions/transaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  List<TransactionModel> transactionNotifier = ([]);
//function add

  Future<void> insertTransactions(TransactionModel transaction) async {
    final transactionDb =
        await Hive.openBox<TransactionModel>('transaction_db');
    await transactionDb.put(transaction.id, transaction);
    alertUi();
  }

//function to getvalues

  Future<List<TransactionModel>> getTransations() async {
    final transactionDb =
        await Hive.openBox<TransactionModel>('transaction_db');
    return transactionDb.values.toList();
  }

//functions

  Future<void> alertUi() async {
    final allTransactions = await getTransations();
    allTransactions.sort(
      (first, second) => second.date.compareTo(first.date),
    );
    transactionNotifier.clear();
    transactionNotifier.addAll(allTransactions);

    notifyListeners();
  }

//delete

  Future<void> deleteTransaction(String transId) async {
    final transactionDb =
        await Hive.openBox<TransactionModel>('transaction_db');
    await transactionDb.delete(transId);
    alertUi();
  }
}
