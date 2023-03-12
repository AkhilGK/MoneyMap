import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transaction_model.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transactions_functions.dart';
import 'package:moneymap/homescreen/screens/edit_and_delete_Screen/edit_delete.dart';

class FirstScreenWidget {
  //add button

  //A recent transactions widget
  Widget listtileRecent(ctx) {
    // ignore: prefer_const_constructors
    return ValueListenableBuilder(
      valueListenable: transactionNotifier,
      builder: (context, List<TransactionModel> newList, _) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentCount(),
          itemBuilder: (context, index) {
            TransactionModel value = newList[index];
            return Card(
              elevation: 1,
              child: ListTile(
                onLongPress: () => deleteTransaction(value.id!),
                onTap: () {
                  Navigator.of(ctx).push(MaterialPageRoute(
                    builder: (context) {
                      return EditAndDeleteScreen(
                        amount: value.amount,
                        name: value.name,
                        category: value.categoryName,
                        date: value.date,
                        isIncome: value.isIncome,
                        id: value.id!,
                      );
                    },
                  ));
                },
                leading: CircleAvatar(
                  child: Text(dateText(value)),
                  backgroundColor: Color.fromRGBO(197, 168, 202, 1),
                ),
                title: Text(value.name.toString(),
                    style: TextStyle(color: Colors.black87, fontSize: 18)),
                subtitle: Text(value.categoryName.toString(),
                    style: const TextStyle(
                        color: Color.fromARGB(255, 88, 17, 17), fontSize: 15)),
                trailing: Text(
                  '₹${value.amount}',
                  style: TextStyle(
                      color: value.isIncome ? Colors.green : Colors.red,
                      fontSize: 20),
                ),
              ),
            );
          },
        );
      },
    );
  }

  int recentCount() {
    if (transactionNotifier.value.length < 5) {
      return transactionNotifier.value.length;
    } else {
      return 5;
    }
  }

  //A custome text widget

  Widget moneyMapText({
    required String text,
    required double size,
    required Color color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
    );
  }

//A sized box
  Widget sbox() {
    return SizedBox(
      height: 10,
    );
  }

  Icon iconFunction(bool val) {
    return val
        ? Icon(
            Icons.attach_money_rounded,
            color: Colors.green,
          )
        : Icon(
            Icons.shopping_cart,
            color: Colors.red,
          );
  }

  String dateText(TransactionModel val) {
    return DateFormat('MMM\nd').format(val.date);
  }
  // Text textTitle(TransactionModel val) {return val.isIncome? Text('₹${val.amount}',):Text()}
}
