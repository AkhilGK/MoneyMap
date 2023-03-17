// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transactions_functions.dart';
import 'package:moneymap/homescreen/screens/widgets/empty_message.dart';
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
  ValueNotifier<String> dropdownValue =
      ValueNotifier('All transactions'); //to select the type
  TextEditingController searchController = TextEditingController();
  List<TransactionModel> listToDisplay =
      transactionNotifier.value; //take all value from main list
  ValueNotifier<List<TransactionModel>> outputList = ValueNotifier([]);
  String query = '';
  // Variables for date range
  DateTime? startDate;
  DateTime? endDate;
  @override
  void initState() {
    outputList.value = listToDisplay;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      suffixIcon: const Icon(Icons.clear),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      filled: true,
                      fillColor: Colors.white54),
                  onChanged: (value) => setState(() {
                    query = value;
                  }),
                ),
              ),
              DropdownButton(
                value: dropdownValue.value,
                items: dropItems.map((items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue.value = newValue!;
                    dropdownValue.notifyListeners();
                  });
                },
              ),
              const Text(
                'Select a Date range',
                style: TextStyle(fontSize: 20, color: Colors.purple),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue, width: 2)),
                onPressed: () {
                  showCustomDateRangePicker(
                    context,
                    dismissible: true,
                    minimumDate: DateTime(2010),
                    maximumDate: DateTime.now(),
                    endDate: endDate,
                    startDate: startDate,
                    onApplyClick: (start, end) {
                      setState(() {
                        endDate = end;
                        startDate = start;
                      });
                    },
                    onCancelClick: () {
                      setState(() {
                        endDate = null;
                        startDate = null;
                      });
                    },
                  );
                },
                child: startDate == null
                    ? const Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey,
                      )
                    : Text(
                        style: const TextStyle(color: Colors.grey),
                        '${startDate != null ? DateFormat("dd/MMM/yyyy").format(startDate!) : '-'} - ${endDate != null ? DateFormat("dd/MMM/yyyy").format(endDate!) : '-'}',
                      ),
              ),
              transactionNotifier.value.isEmpty
                  ? const EmptyMesssage()
                  : ValueListenableBuilder(
                      valueListenable: dropdownValue,
                      builder: (context, typeSelected, _) {
                        //without date range

                        if (startDate == null && endDate == null) {
                          if (typeSelected == dropItems[0]) {
                            outputList.value = listToDisplay
                                .where((element) =>
                                    element.categoryName
                                        .toLowerCase()
                                        .contains(query.toLowerCase()) ||
                                    element.name
                                        .toLowerCase()
                                        .contains(query.toLowerCase()))
                                .toList();
                            outputList.notifyListeners();
                          } else if (typeSelected == dropItems[1]) {
                            outputList.value = listToDisplay
                                .where((element) =>
                                    element.isIncome == true &&
                                    (element.categoryName
                                            .toLowerCase()
                                            .contains(query.toLowerCase()) ||
                                        element.name
                                            .toLowerCase()
                                            .contains(query.toLowerCase())))
                                .toList();
                            outputList.notifyListeners();
                          } else {
                            outputList.value = listToDisplay
                                .where((element) =>
                                    element.isIncome == false &&
                                    (element.categoryName
                                            .toLowerCase()
                                            .contains(query.toLowerCase()) ||
                                        element.name
                                            .toLowerCase()
                                            .contains(query.toLowerCase())))
                                .toList();
                            outputList.notifyListeners();
                          }
                          return ValueListenableBuilder(
                            valueListenable: outputList,
                            builder:
                                (context, List<TransactionModel> newList, _) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: outputList.value.length,
                                itemBuilder: (context, index) {
                                  TransactionModel value = newList[index];
                                  return Card(
                                    elevation: 1,
                                    child: ListTile(
                                      onLongPress: () =>
                                          deleteTransaction(value.id!),
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
                                        backgroundColor: const Color.fromRGBO(
                                            197, 168, 202, 1),
                                        child: Text(dateText(value)),
                                      ),
                                      title: Text(value.name.toString(),
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 18)),
                                      subtitle: Text(
                                          value.categoryName.toString(),
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 88, 17, 17),
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
                        }

                        //with date range

                        else {
                          if (typeSelected == dropItems[0]) {
                            outputList.value = listToDisplay
                                .where((element) =>
                                    element.categoryName
                                        .toLowerCase()
                                        .contains(query.toLowerCase()) ||
                                    element.name
                                        .toLowerCase()
                                        .contains(query.toLowerCase()))
                                .where((element) =>
                                    element.date.isBefore(endDate!
                                        .add(const Duration(days: 1))) &&
                                    element.date.isAfter(startDate!
                                        .subtract(const Duration(days: 1))))
                                .toList();
                            outputList.notifyListeners();
                          } else if (typeSelected == dropItems[1]) {
                            outputList.value = listToDisplay
                                .where((element) =>
                                    element.isIncome == true &&
                                    (element.categoryName
                                            .toLowerCase()
                                            .contains(query.toLowerCase()) ||
                                        element.name
                                            .toLowerCase()
                                            .contains(query.toLowerCase())))
                                .where((element) =>
                                    element.date.isBefore(endDate!) &&
                                    element.date.isAfter(startDate!))
                                .toList();
                            outputList.notifyListeners();
                          } else {
                            outputList.value = listToDisplay
                                .where((element) =>
                                    element.isIncome == false &&
                                    (element.categoryName
                                            .toLowerCase()
                                            .contains(query.toLowerCase()) ||
                                        element.name
                                            .toLowerCase()
                                            .contains(query.toLowerCase())))
                                .where((element) =>
                                    element.date.isBefore(endDate!) &&
                                    element.date.isAfter(startDate!))
                                .toList();
                            outputList.notifyListeners();
                          }
                          return ValueListenableBuilder(
                            valueListenable: outputList,
                            builder:
                                (context, List<TransactionModel> newList, _) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: outputList.value.length,
                                itemBuilder: (context, index) {
                                  TransactionModel value = newList[index];
                                  return Card(
                                    elevation: 1,
                                    child: ListTile(
                                      onLongPress: () =>
                                          deleteTransaction(value.id!),
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
                                        radius: 23,
                                        backgroundColor: const Color.fromRGBO(
                                            197, 168, 202, 1),
                                        child: Text(dateText(value)),
                                      ),
                                      title: Text(value.name.toString(),
                                          style: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 18)),
                                      subtitle: Text(
                                          value.categoryName.toString(),
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 88, 17, 17),
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
                        }
                      },
                    )
            ],
          ),
        ),
      )),
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
    return DateFormat('MMM\nd').format(val.date);
  }
}
