// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymap/homescreen/screens/search/search_functions.dart';
import 'package:moneymap/homescreen/screens/widgets/empty_message.dart';
import 'package:moneymap/providers/search_provider.dart';
import 'package:provider/provider.dart';
import '../../../providers/transaction_provider.dart';
import '../add transactions/db_transactions/transaction_model.dart';
import '../edit_and_delete_Screen/edit_delete.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';

class SearchAndView extends StatefulWidget {
  const SearchAndView({super.key});

  @override
  State<SearchAndView> createState() => _SearchAndViewState();
}

class _SearchAndViewState extends State<SearchAndView> {
  List<String> dropItems = ['All transactions', 'Income', 'Expense'];
  // ValueNotifier<String> dropdownValue =
  //     ValueNotifier('All transactions'); //to select the type

  TextEditingController searchController = TextEditingController();
  //take all value from main list
  // String query = '';
  // Variables for date range
  // DateTime? startDate;
  // DateTime? endDate;
  @override
  void initState() {
    super.initState();
    context.read<SearchProvider>().dropdownValue = 'All transactions';
    context.read<SearchProvider>().startDate = null;
    context.read<SearchProvider>().endDate = null;
  }

  @override
  Widget build(BuildContext context) {
    List<TransactionModel> listToDisplay =
        Provider.of<TransactionProvider>(context, listen: false)
            .transactionNotifier;
    ValueNotifier<List<TransactionModel>> outputList = ValueNotifier([]);

    outputList.value = listToDisplay;

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      filled: true,
                      fillColor: Colors.white54),
                  onChanged: (value) =>
                      context.read<SearchProvider>().queryfun(value),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 219, 207, 221),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DropdownButton(
                    value: Provider.of<SearchProvider>(context).dropdownValue,
                    items: dropItems.map((items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      Provider.of<SearchProvider>(context, listen: false)
                          .dropDownfun(newValue!);
                    },
                  ),
                ),
              ),
              const Text(
                'Select a Date range',
                style: TextStyle(fontSize: 20, color: Colors.purple),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.purple, width: 2)),
                onPressed: () {
                  showCustomDateRangePicker(
                    context,
                    dismissible: true,
                    minimumDate: DateTime(2010),
                    maximumDate: DateTime.now(),
                    endDate: Provider.of<SearchProvider>(context, listen: false)
                        .endDate,
                    startDate:
                        Provider.of<SearchProvider>(context, listen: false)
                            .startDate,
                    onApplyClick: (start, end) {
                      Provider.of<SearchProvider>(context, listen: false)
                          .customDateApply(start, end);
                    },
                    onCancelClick: () {
                      Provider.of<SearchProvider>(context, listen: false)
                          .customDateCancel();
                    },
                  );
                },
                child: context.watch<SearchProvider>().startDate == null
                    ? const Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey,
                      )
                    : Text(
                        style: const TextStyle(color: Colors.grey),
                        '${context.watch<SearchProvider>().startDate != null ? DateFormat("dd/MMM/yyyy").format(context.watch<SearchProvider>().startDate!) : '-'} - ${context.watch<SearchProvider>().endDate != null ? DateFormat("dd/MMM/yyyy").format(context.watch<SearchProvider>().endDate!) : '-'}',
                      ),
              ),
              Provider.of<TransactionProvider>(context, listen: false)
                      .transactionNotifier
                      .isEmpty
                  ? const EmptyMesssage()
                  : Consumer<SearchProvider>(
                      // valueListenable: dropdownValue,
                      builder: (context, providerModel, _) {
                        //without date range

                        return ValueListenableBuilder(
                          valueListenable: searchFunction(
                            queryString: context.read<SearchProvider>().query,
                            transactionType: providerModel.dropdownValue!,
                            startDate: context.read<SearchProvider>().startDate,
                            endDate: context.read<SearchProvider>().endDate,
                            ctx: context,
                          ),
                          builder:
                              (context, List<TransactionModel> newList, _) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: newList.length,
                              itemBuilder: (context, index) {
                                TransactionModel value = newList[index];
                                return Card(
                                  elevation: 1,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
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
                                      backgroundColor: const Color.fromARGB(
                                          255, 234, 218, 235),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            dateText(value),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    title: Text(value.name.toString(),
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 18)),
                                    subtitle: Text(
                                        value.categoryName.toString(),
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 88, 17, 17),
                                            fontSize: 15)),
                                    trailing: Text(
                                      '₹${value.amount}',
                                      style: TextStyle(
                                          color: value.isIncome
                                              ? Colors.green
                                              : Colors.red,
                                          fontSize: 20),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    )
            ],
          ),
        ),
      )),
    );
  }

  String dateText(TransactionModel val) {
    return DateFormat('MMM\n d').format(val.date);
  }
}
