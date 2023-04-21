// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:moneymap/homescreen/screens/widgets/empty_message.dart';
import 'package:moneymap/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../add transactions/db_transactions/transaction_model.dart';
import '../add transactions/db_transactions/transactions_functions.dart';

class AllStats extends StatelessWidget {
  AllStats({super.key});
  List<int> allStats = [];
  @override
  Widget build(BuildContext context) {
    return Provider.of<TransactionProvider>(context, listen: false)
            .transactionNotifier
            .isEmpty
        ? const EmptyMesssage()
        : Consumer<TransactionProvider>(
            // valueListenable: transactionNotifier,
            builder: (context, providerModel, _) {
              final transactions = providerModel.transactionNotifier;
              double incomeTotal = 0;
              double expenseTotal = 0;
              for (var element in transactions) {
                if (element.isIncome == true) {
                  incomeTotal = incomeTotal + element.amount;
                } else {
                  expenseTotal = expenseTotal + element.amount;
                }
              }
              Map incomeMap = {'name': 'Income', 'amount': incomeTotal};
              Map expenseMap = {'name': 'Expense', 'amount': expenseTotal};
              List<Map> allStats = [incomeMap, expenseMap];

              //made a list of map to give as data source

              return SfCircularChart(
                title: ChartTitle(text: 'All transactions'),
                legend: Legend(
                    isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                series: <CircularSeries>[
                  DoughnutSeries(
                    dataSource: allStats,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    xValueMapper: (allStats, _) => allStats['name'],
                    yValueMapper: (allstats, _) => allstats['amount'],
                  )
                ],
              );
            },
          );
  }
}
