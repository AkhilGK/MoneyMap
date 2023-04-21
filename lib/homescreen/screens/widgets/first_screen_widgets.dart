import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transaction_model.dart';
import 'package:moneymap/homescreen/screens/edit_and_delete_Screen/edit_delete.dart';
import 'package:moneymap/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

import 'empty_message.dart';

class FirstScreenWidget {
  //add button

  //A recent transactions widget
  Widget listtileRecent(ctx) {
    // ignore: prefer_const_constructors

    return Consumer<TransactionProvider>(
      // valueListenable: transactionNotifier,
      builder: (context, providerModel, _) {
        final newList = providerModel.transactionNotifier;
        return newList.isEmpty
            ? const EmptyMesssage()
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recentCount(context),
                itemBuilder: (context, index) {
                  TransactionModel value = newList[index];
                  return Card(
                    elevation: 1,
                    child: ListTile(
                      // onLongPress: () => deleteTransaction(value.id!),
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
                        radius: 25,
                        backgroundColor:
                            const Color.fromARGB(255, 234, 218, 235),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              dateText(value),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      title: Text(value.name.toString(),
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 18)),
                      subtitle: Text(value.categoryName.toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 88, 17, 17),
                              fontSize: 15)),
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

  int recentCount(BuildContext ctx) {
    if (Provider.of<TransactionProvider>(ctx, listen: false)
            .transactionNotifier
            .length <
        5) {
      return Provider.of<TransactionProvider>(ctx, listen: false)
          .transactionNotifier
          .length;
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
    return const SizedBox(
      height: 10,
    );
  }

  Icon iconFunction(bool val) {
    return val
        ? const Icon(
            Icons.attach_money_rounded,
            color: Colors.green,
          )
        : const Icon(
            Icons.shopping_cart,
            color: Colors.red,
          );
  }

  String dateText(TransactionModel val) {
    return DateFormat('MMM\n d').format(val.date);
  }
}
