import 'package:flutter/material.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/add_expense.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/add_income.dart';

class AddTransaction extends StatelessWidget {
  const AddTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        automaticallyImplyLeading: false,
        title: const Center(
            child: Text(
          "Transactions",
          style: TextStyle(fontSize: 23),
        )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultTabController(
            length: 2, // length of tabs
            initialIndex: 0,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(255, 228, 216, 225)),
                        height: 50,
                        child: TabBar(
                          indicatorPadding: const EdgeInsets.all(6),
                          indicator: BoxDecoration(
                              // border: Border.all(),
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.purple),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black87,
                          tabs: const [
                            Tab(
                              child: Text(
                                'Income',
                                style: TextStyle(fontSize: 18),
                              ),
                              // text: "Income",
                            ),
                            Tab(
                              child: Text(
                                'Expense',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 600,
                      child: TabBarView(
                          children: <Widget>[AddIncome(), AddExpense()]),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
