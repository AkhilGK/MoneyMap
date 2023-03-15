// import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transactions_functions.dart';
import '../add transactions/db_transactions/transaction_model.dart';
import 'first_screen_widgets.dart';

class FirstFlipCard extends StatelessWidget {
  FirstFlipCard({super.key});
  double totalIncome = 0;
  double totalExpense = 0;
  double savings = 0;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: transactionNotifier,
      builder: (context, List<TransactionModel> transList, _) {
        totalExpense = 0;
        totalIncome = 0;
        savings = 0;
        for (var tlist in transList) {
          if (tlist.isIncome) {
            totalIncome = totalIncome + tlist.amount;
          } else {
            totalExpense = totalExpense + tlist.amount;
          }
        }
        savings = totalIncome - totalExpense;
        return FlipCard(
          autoFlipDuration: const Duration(seconds: 10),
          fill: Fill
              .fillBack, // Fill the back side of the card to make in the same size as the front.
          direction: FlipDirection.VERTICAL, // default
          side: CardSide.FRONT, // The side to initially display.
          front: Container(
            width: 260,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromRGBO(186, 95, 202, 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FirstScreenWidget().moneyMapText(
                        text: 'Savings',
                        size: 24,
                        color: Colors.white70,
                      ),
                      SizedBox(
                        height: 45,
                        child: Image.asset("Assets/images/LoginImg.png"),
                      )
                    ],
                  ),
                  FirstScreenWidget().sbox(),
                  FirstScreenWidget().moneyMapText(
                      text: "Your current balance",
                      size: 18,
                      color: Colors.white60),
                  FirstScreenWidget().sbox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FirstScreenWidget().moneyMapText(
                          text:
                              "₹${double.parse((savings).toStringAsFixed(2))}",
                          size: 22,
                          color: Colors.white),
                    ],
                  ),
                  FirstScreenWidget().sbox(),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          FirstScreenWidget().moneyMapText(
                              text: "Savings & Expense",
                              size: 18,
                              color: const Color.fromARGB(255, 136, 29, 155)),
                        ],
                      ),
                      FirstScreenWidget().sbox(),
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
                                FirstScreenWidget().moneyMapText(
                                    text: "Total Income",
                                    size: 18,
                                    color: Colors.black87),
                                FirstScreenWidget().moneyMapText(
                                    text:
                                        "₹${double.parse((totalIncome).toStringAsFixed(2))}",
                                    size: 22,
                                    color: Colors.green),
                              ],
                            )
                          ],
                        ),
                      ),
                      FirstScreenWidget().sbox(),
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
                                FirstScreenWidget().moneyMapText(
                                    text: "Total Expense",
                                    size: 18,
                                    color: Colors.black),
                                FirstScreenWidget().moneyMapText(
                                    text:
                                        "₹${double.parse((totalExpense).toStringAsFixed(2))}",
                                    size: 22,
                                    color: Colors.red),
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
      },
    );
  }
}
