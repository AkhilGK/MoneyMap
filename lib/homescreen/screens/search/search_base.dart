import 'package:flutter/material.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transactions_functions.dart';

import '../add transactions/db_transactions/transaction_model.dart';
import '../edit_and_delete_Screen/edit_delete.dart';

class SearchAndView extends StatelessWidget {
  const SearchAndView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'All transactions',
              style: TextStyle(fontSize: 20, color: Colors.purple),
            ),
            ValueListenableBuilder(
              valueListenable: transactionNotifier,
              builder: (context, List<TransactionModel> transactionList, _) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactionNotifier.value.length,
                  itemBuilder: (context, index) {
                    TransactionModel value = transactionList[index];
                    return Card(
                      elevation: 1,
                      child: ListTile(
                        onLongPress: () => deleteTransaction(value.id!),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
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
                          child: iconFunction(value.isIncome),
                          backgroundColor: Color.fromRGBO(197, 168, 202, 1),
                        ),
                        title: Text(value.name.toString(),
                            style:
                                TextStyle(color: Colors.black87, fontSize: 18)),
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
            )
          ],
        ),
      )),
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
}
