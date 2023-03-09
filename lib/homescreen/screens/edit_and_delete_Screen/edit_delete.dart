import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:moneymap/homescreen/home_screen.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transaction_model.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transactions_functions.dart';
import 'package:moneymap/homescreen/screens/first_screen.dart';

import '../add_categories/db_categories/categories_db_functions.dart';
import '../add_categories/db_categories/categories_db_model.dart';
import '../widgets/global_widgets.dart';

class EditAndDeleteScreen extends StatefulWidget {
  double amount;
  String name;
  String category;
  DateTime date;
  bool isIncome;
  String id;
  EditAndDeleteScreen(
      {super.key,
      required this.amount,
      required this.name,
      required this.category,
      required this.date,
      required this.isIncome,
      required this.id});

  @override
  State<EditAndDeleteScreen> createState() => _EditAndDeleteScreenState();
}

class _EditAndDeleteScreenState extends State<EditAndDeleteScreen> {
  TextEditingController amountcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  late String categorycontroller;
  TextEditingController datecontroller = TextEditingController();
  late String formattedDate;
  late DateTime selectedDate;
  late String id;

  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    amountcontroller = TextEditingController(text: widget.amount.toString());
    namecontroller = TextEditingController(text: widget.name);
    categorycontroller = widget.category;
    formattedDate = DateFormat('dd-MM-yyyy').format(widget.date);
    datecontroller = TextEditingController(text: formattedDate);
    id = widget.id;
    selectedDate = widget.date;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(formattedDate),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                G().sBox(h: 15),
                TextFormField(
                  controller: amountcontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter amount',
                    labelText: 'Amount ',
                  ),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return ' Name is Required';
                  //   } else {
                  //     return null;
                  //   }
                  // },
                ),
                G().sBox(h: 15),
                TextFormField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: ' Income Name',
                    labelText: 'Income Name',
                  ),
                ),
                G().sBox(h: 15),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      label: Text(widget.category),
                      hintText: widget.category,
                      border: OutlineInputBorder()),
                  items: categoryList(widget.isIncome),
                  // value: categorycontroll,
                  onChanged: (newvalue) {
                    setState(() {
                      categorycontroller = newvalue!.catName;
                    });
                  },
                ),
                G().sBox(h: 15),
                TextField(
                  controller:
                      datecontroller, //editing controller of this TextField
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
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      selectedDate = pickedDate;
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        datecontroller.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
                G().sBox(h: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(179, 224, 53, 11)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                        ),
                        //to show an alertbox for delete button
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext ctx) => AlertDialog(
                              title: Text("Sure to delete"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      deleteTransaction(widget.id);
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()),
                                        (Route<dynamic> route) => false,
                                      );
                                    },
                                    child: Text('Delete')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Back'))
                              ],
                            ),
                          );
                        },
                        child: Icon(Icons.delete)),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(179, 14, 201, 45)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                          //is edited or not

                          if (namecontroller.text == widget.name &&
                              amountcontroller.text ==
                                  widget.amount.toString() &&
                              categorycontroller == widget.category) {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (Route<dynamic> route) => false,
                            );
                          } else {
                            TransactionModel value = TransactionModel(
                                isIncome: widget.isIncome,
                                amount: double.parse(amountcontroller.text),
                                name: namecontroller.text,
                                categoryName: categorycontroller,
                                date: selectedDate,
                                id: id);
                            insertTransactions(value);
                          }
                        },
                        child: const Icon(Icons.check)),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  } //dropdown items

  List<DropdownMenuItem<CategoryModel>> categoryList(bool val) {
    return val
        ? dropDownIncomeCategories.value
            .map((cat) => DropdownMenuItem(
                  value: cat,
                  child: Center(child: Text(cat.catName)),
                ))
            .toList()
        : dropDownExpenseCategories.value
            .map((cat) => DropdownMenuItem(
                  value: cat,
                  child: Center(child: Text(cat.catName)),
                ))
            .toList();
  }

  final snackBar = const SnackBar(
    content: Text('Saved Changes!'),
    backgroundColor: (Color.fromARGB(195, 223, 91, 212)),
  );
}
