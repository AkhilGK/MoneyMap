import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/add_transaction.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transaction_model.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transactions_functions.dart';
import 'package:moneymap/homescreen/screens/edit_and_delete_Screen/edit_delete.dart';
import 'package:path/path.dart';
import 'package:moneymap/homescreen/screens/first_screen.dart';

class FirstScreenWidget {
  Widget flipCard() {
    return FlipCard(
      fill: Fill
          .fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.VERTICAL, // default
      side: CardSide.FRONT, // The side to initially display.
      front: Container(
        width: 260,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Color.fromRGBO(186, 95, 202, 1),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  moneyMapText(
                    text: 'Savings',
                    size: 24,
                    color: Colors.white70,
                  ),
                  Container(
                    child: Image.asset("Assets/images/LoginImg.png"),
                    height: 45,
                  )
                ],
              ),
              sbox(),
              moneyMapText(
                  text: "Your current balance",
                  size: 18,
                  color: Colors.white60),
              sbox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  moneyMapText(
                      text: '₹64,300.00', size: 22, color: Colors.white),
                ],
              ),
              sbox(),
            ],
          ),
        ),
      ),
      //.
      //back of flip card
      //.
      back: Container(
        width: 260,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      moneyMapText(
                          text: "Savings & Expense",
                          size: 18,
                          color: Color.fromARGB(255, 136, 29, 155)),
                    ],
                  ),
                  sbox(),
                  // ignore: prefer_const_constructors
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: const [
                            CircleAvatar(
                              radius: 16,
                              child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.currency_rupee)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            moneyMapText(
                                text: "Total Income",
                                size: 18,
                                color: Colors.black87),
                            moneyMapText(
                                text: "₹762,598",
                                size: 22,
                                color: Colors.green),
                          ],
                        )
                      ],
                    ),
                  ),
                  sbox(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: const [
                            CircleAvatar(
                              radius: 16,
                              child: CircleAvatar(
                                  radius: 14,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.shopify_outlined)),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            moneyMapText(
                                text: "Total Expense",
                                size: 18,
                                color: Colors.black),
                            moneyMapText(
                                text: "₹762,598", size: 22, color: Colors.red),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  } //add button

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
                  child: iconFunction(value.isIncome),
                  backgroundColor: Color.fromRGBO(186, 95, 202, 1),
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
            Icons.money,
            color: Colors.green,
          )
        : Icon(
            Icons.shopping_cart,
            color: Colors.red,
          );
  }

  // Text textTitle(TransactionModel val) {return val.isIncome? Text('₹${val.amount}',):Text()}
}
