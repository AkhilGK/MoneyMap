import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:moneymap/homescreen/screens/add_categories/db_categories/categories_db_functions.dart';

import '../add_categories/categories_list.dart';

class AddExpense extends StatefulWidget {
  AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController dateinput = TextEditingController();
  String _selectedCategory = "";
  List<String> dropdownExpitems =
      dropDownExpenseCategories.value.map((data) => data.catName).toList();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              sboxex(h: 20),
              Row(
                children: const [
                  Text("Amount & Payments"),
                ],
              ),
              sboxex(h: 15),
              TextFormField(
                // controller: _nameOfStudent,
                keyboardType: TextInputType.number,
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
                // controller: _nameOfStudent,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: ' Expense Name',
                  labelText: 'Expense Name',
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
              ValueListenableBuilder(
                valueListenable: dropDownExpenseCategories,
                builder: (context, categoryList, child) {
                  return DropdownButtonFormField(
                    decoration: const InputDecoration(
                        label: Text("Category"),
                        // hintText: "Select a category",
                        border: OutlineInputBorder()),
                    items: categoryList
                        .map((data) => DropdownMenuItem(
                              value: data,
                              child: Center(child: Text(data.catName)),
                            ))
                        .toList(),
                    // value: _selectedCategory,
                    onChanged: (newvalue) {
                      setState(() {
                        _selectedCategory =
                            newvalue.toString(); //on the income page
                      });
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
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    print(pickedDate.month);
                  }

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      dateinput.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
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
                    if (_formKey.currentState!.validate()) {}
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

}
