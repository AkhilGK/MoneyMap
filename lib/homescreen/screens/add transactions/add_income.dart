import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transaction_model.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transactions_functions.dart';
import 'package:moneymap/homescreen/screens/widgets/global_widgets.dart';

import '../add_categories/categories_list.dart';
import '../add_categories/db_categories/categories_db_functions.dart';
import '../bottom_nav/home_screen.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  String _selectedCategory = "";
  TextEditingController dateinput = TextEditingController();
  DateTime dateSelected = DateTime.now();
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  // TextEditingController categoryController = TextEditingController();
  // List<String> dropdownitems =
  //     dropDownIncomeCategories.value.map((data) => data.catName).toList();
  final _formKey = GlobalKey<FormState>(); //for form validation
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              G().sBox(h: 20),
              Row(
                children: [
                  G().textOfMap(
                      text: "Amount & Payments", size: 20, color: Colors.purple)
                ],
              ),
              G().sBox(h: 15),

              //amount

              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 12,
                controller: amountController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter amount',
                  labelText: 'Amount',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ' Amount is Required';
                  } else {
                    return null;
                  }
                },
              ),
              G().sBox(h: 15),

              //income name

              TextFormField(
                controller: nameController,
                maxLength: 30,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: ' Income Name',
                  labelText: 'Income Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ' Name is Required';
                  } else {
                    return null;
                  }
                },
              ),
              G().sBox(h: 15),

              //to a select category

              ValueListenableBuilder(
                valueListenable: dropDownIncomeCategories,
                builder: (context, dropDownIncomeCategories, child) {
                  return DropdownButtonFormField(
                    decoration: const InputDecoration(
                      label: Text("Category"),
                      hintText: "Select a category",
                      border: OutlineInputBorder(),
                    ),
                    items: dropDownIncomeCategories
                        .map((cat) => DropdownMenuItem(
                              value: cat,
                              child: Center(child: Text(cat.catName)),
                            ))
                        .toList(),
                    onChanged: (newvalue) {
                      setState(() {
                        _selectedCategory = newvalue!.catName;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.catName.isEmpty) {
                        return " Category can't be Empty";
                      } else {
                        return null;
                      }
                    },
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Add a new category"),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const CategoriesList(type: true),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add,
                      )),
                ],
              ),

              //date And ime

              TextFormField(
                controller: dateinput, //editing controller of this TextField
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Enter Date" //label text of field
                    ),
                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(const Duration(
                          days:
                              30)), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    dateSelected = pickedDate;
                    // print(dateSelected.toString());
                    String formattedDate = DateFormat('yMd').format(pickedDate);

                    // print(
                    //     formattedDate); //formatted date output using intl package =>  16-03-2022
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      dateinput.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } //else {
                  //   print("Date is not selected");
                  // }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return " Please chose a date";
                  } else {
                    return null;
                  }
                },
              ),
              G().sBox(h: 20),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(179, 14, 201, 45)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                    ),
                  ),
                  onPressed: () {
                    print(DateTime.now());

                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      TransactionModel value = TransactionModel(
                          isIncome: true, //truebecouse it is income
                          amount: double.parse(amountController.text),
                          name: nameController.text,
                          categoryName: _selectedCategory,
                          date: dateSelected,
                          id: DateTime.now().microsecondsSinceEpoch.toString());
                      insertTransactions(value);
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  child: const Text("Add Income"))
            ],
          ),
        ),
      ),
    );
  }

  final snackBar = const SnackBar(
    content: Text('Saved Changes!'),
    backgroundColor: (Color.fromARGB(195, 223, 91, 212)),
  );
}
