import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transactions_functions.dart';
import 'package:moneymap/providers/add_transaction_provider.dart';
import 'package:moneymap/providers/category_provider.dart';
import 'package:moneymap/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

import '../add_categories/categories_list.dart';
import '../bottom_nav/home_screen.dart';
import '../widgets/global_widgets.dart';
import 'db_transactions/transaction_model.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  // TextEditingController dateinput = TextEditingController();
  // String _selectedCategory = "";
  DateTime dateSelected = DateTime.now();
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  // List<String> dropdownExpitems =
  //     dropDownExpenseCategories.value.map((data) => data.catName).toList();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    context.read<AddtransactionProvider>().dateInExpense('');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              sboxex(h: 20),
              Row(
                children: [
                  G().textOfMap(
                      text: "Amount & Payments", size: 20, color: Colors.purple)
                ],
              ),
              sboxex(h: 15),
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                maxLength: 12,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter expense amount',
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
              sboxex(h: 15),
              TextFormField(
                controller: nameController,
                maxLength: 30,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: ' Expense Name',
                  labelText: 'Expense Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ' Name is Required';
                  } else {
                    return null;
                  }
                },
              ),
              sboxex(h: 15),
              Consumer<CategoryProvider>(
                // valueListenable: dropDownExpenseCategories,
                builder: (context, providerModel, child) {
                  final expList = providerModel.dropDownExpenseCategories;
                  return DropdownButtonFormField(
                    decoration: const InputDecoration(
                        label: Text("Category"),
                        // hintText: "Select a category",
                        border: OutlineInputBorder()),
                    items: expList
                        .map((data) => DropdownMenuItem(
                              value: data,
                              child: Center(child: Text(data.catName)),
                            ))
                        .toList(),
                    // value: _selectedCategory,
                    onChanged: (newvalue) {
                      Provider.of<AddtransactionProvider>(context,
                              listen: false)
                          .incomeCategoryFun(newvalue!.catName);
                      // setState(() {
                      //   _selectedCategory =
                      //       newvalue!.catName; //on the income page
                      // });
                    },
                    validator: (value) {
                      if (value == null || value.catName.isEmpty) {
                        return "Category can't be Empty";
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
                            builder: (context) => CategoriesList(type: false),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add,
                      )),
                ],
              ),
              TextFormField(
                controller:
                    context.watch<AddtransactionProvider>().dateinputExpense,
                //editing controller of this TextField
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
                    dateSelected = pickedDate;
                    // print(pickedDate.month);
                  }

                  if (pickedDate != null) {
                    //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);

                    //you can implement different kind of Date Format here according to your requirement

                    // ignore: use_build_context_synchronously
                    Provider.of<AddtransactionProvider>(context, listen: false)
                        .dateInExpense(formattedDate);
                    // setState(() {
                    //   dateinput.text =
                    //       formattedDate; //set output date to TextField value.
                    // });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return " Please chose a date";
                  } else {
                    return null;
                  }
                },
              ),
              sboxex(h: 20),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 230, 47, 34)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      TransactionModel value = TransactionModel(
                          isIncome: false,
                          amount: double.parse(amountController.text),
                          name: nameController.text,
                          categoryName: context
                              .read<AddtransactionProvider>()
                              .selectedIncomeCategory,
                          date: dateSelected,
                          id: DateTime.now().microsecondsSinceEpoch.toString());
                      Provider.of<TransactionProvider>(context, listen: false)
                          .insertTransactions(value);
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  child: const Text("Add Expense"))
            ],
          ),
        ),
      ),
    );
  } //sboxexacustomsizedbox

  Widget sboxex({required double h}) {
    return SizedBox(
      height: h,
    );
  } //dropdown items

  final snackBar = const SnackBar(
    content: Text('Saved Changes!'),
    backgroundColor: (Color.fromARGB(195, 223, 91, 212)),
  );
}
