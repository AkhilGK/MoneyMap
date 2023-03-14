import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transactions_functions.dart';

import '../add transactions/db_transactions/transaction_model.dart';
import '../edit_and_delete_Screen/edit_delete.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';

class SearchAndView extends StatefulWidget {
  SearchAndView({super.key});

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
    // TODO: implement initState

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
                    side: BorderSide(color: Colors.blue, width: 2)),
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
                    ? Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey,
                      )
                    : Text(
                        style: TextStyle(color: Colors.grey),
                        '${startDate != null ? DateFormat("dd/MMM/yyyy").format(startDate!) : '-'} - ${endDate != null ? DateFormat("dd/MMM/yyyy").format(endDate!) : '-'}',
                      ),
              ),
              ValueListenableBuilder(
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
                      print(outputList.value.length);
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
                      print(outputList.value.length);
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
                      print(outputList.value.length);
                    }
                    return ValueListenableBuilder(
                      valueListenable: outputList,
                      builder: (context, List<TransactionModel> newList, _) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: outputList.value.length,
                          itemBuilder: (context, index) {
                            TransactionModel value = newList[index];
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
                                  child: Text(dateText(value)),
                                  backgroundColor:
                                      Color.fromRGBO(197, 168, 202, 1),
                                ),
                                title: Text(value.name.toString(),
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 18)),
                                subtitle: Text(value.categoryName.toString(),
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 88, 17, 17),
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
                              element.date.isBefore(endDate!) &&
                              element.date.isAfter(startDate!))
                          .toList();
                      outputList.notifyListeners();
                      print(outputList.value.length);
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
                      print(outputList.value.length);
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
                      print(outputList.value.length);
                    }
                    return ValueListenableBuilder(
                      valueListenable: outputList,
                      builder: (context, List<TransactionModel> newList, _) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: outputList.value.length,
                          itemBuilder: (context, index) {
                            TransactionModel value = newList[index];
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
                                  child: Text(dateText(value)),
                                  backgroundColor:
                                      Color.fromRGBO(197, 168, 202, 1),
                                ),
                                title: Text(value.name.toString(),
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 18)),
                                subtitle: Text(value.categoryName.toString(),
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 88, 17, 17),
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
        ? Icon(
            Icons.attach_money_rounded,
            color: Colors.green,
          )
        : Icon(
            Icons.shopping_cart,
            color: Colors.red,
          );
  }

  void searchResult(String searchKey) {
    if (searchKey.isEmpty) {
      outputList.value = listToDisplay;
    } else if (searchKey.isEmpty || dropdownValue == 'Income') {
      outputList.value.clear();
      outputList.value.addAll(
          listToDisplay.where((element) => element.isIncome == true).toList());
      outputList.notifyListeners();
    }
  }

  String dateText(TransactionModel val) {
    return DateFormat('MMM\nd').format(val.date);
  }
}
