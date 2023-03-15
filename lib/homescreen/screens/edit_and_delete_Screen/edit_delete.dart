import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transaction_model.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transactions_functions.dart';

import '../add_categories/db_categories/categories_db_functions.dart';
import '../add_categories/db_categories/categories_db_model.dart';
import '../bottom_nav/home_screen.dart';
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

  @override
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
                  keyboardType: TextInputType.number,
                  controller: amountcontroller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter amount',
                    labelText: 'Amount ',
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
                TextFormField(
                  controller: namecontroller,
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
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      label: Text(widget.category),
                      hintText: widget.category,
                      border: const OutlineInputBorder()),
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
                      selectedDate = pickedDate;
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);

                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        datecontroller.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      return;
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
                              const Color.fromARGB(179, 224, 53, 11)),
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
                              title: const Text("Sure to delete"),
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
                                    child: const Text('Delete')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Back'))
                              ],
                            ),
                          );
                        },
                        child: const Icon(Icons.delete)),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(179, 14, 201, 45)),
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
                          } else if (_formkey.currentState!.validate()) {
                            TransactionModel value = TransactionModel(
                                isIncome: widget.isIncome,
                                amount: double.parse(amountcontroller.text),
                                name: namecontroller.text,
                                categoryName: categorycontroller,
                                date: selectedDate,
                                id: id);
                            insertTransactions(value);
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (Route<dynamic> route) => false,
                            );
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
