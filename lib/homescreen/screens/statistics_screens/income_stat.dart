import 'package:flutter/material.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transactions_functions.dart';
import 'package:collection/collection.dart';
import 'package:moneymap/homescreen/screens/widgets/empty_message.dart';
import 'package:moneymap/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../add transactions/db_transactions/transaction_model.dart';

class IncomeStat extends StatelessWidget {
  const IncomeStat({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider.of<TransactionProvider>(context, listen: false)
            .transactionNotifier
            .isEmpty
        ? const EmptyMesssage()
        : Consumer<TransactionProvider>(
            // valueListenable: transactionNotifier,
            builder: (context, providerModel, _) {
              //took all the expenses to the list
              final transactions = providerModel.transactionNotifier;
              var allIncomeStat = transactions
                  .where((element) => element.isIncome == true)
                  .toList();
//to group according to the category
              var incomeGroupedCategory = groupBy<TransactionModel, String>(
                allIncomeStat,
                (income) => income.categoryName,
              );

              //convert the grouped data into mapentry objects
              var data = incomeGroupedCategory.entries
                  .map((entry) => MapEntry<String, double>(
                      entry.key,
                      entry.value
                          .fold(0, (total, income) => total = income.amount)))
                  .toList();
              return SfCircularChart(
                title: ChartTitle(text: 'All Income, category wise'),
                series: <CircularSeries>[
                  DoughnutSeries<MapEntry<String, double>, String>(
                    dataSource: data,
                    xValueMapper: (entry, _) => entry.key,
                    yValueMapper: (entry, _) => entry.value,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                    ),
                    // explode: true,
                    // explodeAll: true,
                  )
                ],
                legend: Legend(
                    isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
              );
            },
          );
  }
}
