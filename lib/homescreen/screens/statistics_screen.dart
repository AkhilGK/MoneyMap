import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneymap/homescreen/screens/statistics_screens/all_stat.dart';
import 'package:moneymap/homescreen/screens/statistics_screens/expense_stat.dart';
import 'package:moneymap/homescreen/screens/statistics_screens/income_stat.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTabController(
          length: 3, // length of tabs
          initialIndex: 0,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromARGB(255, 201, 194, 199)),
                      height: 50,
                      child: TabBar(
                        indicatorPadding: EdgeInsets.all(6),
                        indicator: BoxDecoration(
                            // border: Border.all(),
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.purple),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black87,
                        tabs: const [
                          Tab(
                            child: Text(
                              'All',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Income ',
                              style: TextStyle(fontSize: 18),
                            ),
                            // text: "Income",
                          ),
                          Tab(
                            child: Text(
                              'Expense ',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 600,

                    // height: 600, //height of TabBarView
                    // decoration: BoxDecoration(
                    //     border: Border(
                    //         top: BorderSide(color: Colors.grey, width: 0.5))),
                    child: TabBarView(children: <Widget>[
                      AllStats(),
                      IncomeStat(),
                      ExpenseStat(),
                    ]),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
