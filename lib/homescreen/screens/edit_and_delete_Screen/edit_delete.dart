import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../widgets/global_widgets.dart';

class EditAndDeleteScreen extends StatefulWidget {
  double amount;
  String name;
  String category;
  DateTime date;
  EditAndDeleteScreen(
      {super.key,
      required this.amount,
      required this.name,
      required this.category,
      required this.date});

  @override
  State<EditAndDeleteScreen> createState() => _EditAndDeleteScreenState();
}

class _EditAndDeleteScreenState extends State<EditAndDeleteScreen> {
  TextEditingController amountcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  late String categorycontroller;
  late DateTime datecontroller;

  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    amountcontroller = TextEditingController(text: widget.amount.toString());
    namecontroller = TextEditingController(text: widget.name);
    categorycontroller = widget.category;
    datecontroller = widget.date;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('  '),
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
                      label: Text("Category"),
                      // hintText: "Select a category",
                      border: OutlineInputBorder()),
                  items: catagoryList,
                  value: categorycontroller,
                  onChanged: (newvalue) {
                    setState(() {
                      categorycontroller = newvalue.toString();
                    });
                  },
                ),
                G().sBox(h: 15),
                TextField(
                  // controller:
                  //     datecontroller, //editing controller of this TextField
                  decoration: InputDecoration(
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
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                        // dateinput.text =
                        //     formattedDate; //set output date to TextField value.
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
                                    onPressed: () {}, child: Text('Delete')),
                                TextButton(
                                    onPressed: () {}, child: Text('Back'))
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
                        onPressed: () {},
                        child: Icon(Icons.check)),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  } //dropdown items

  List<DropdownMenuItem<dynamic>> catagoryList = [
    DropdownMenuItem(
      value: 'Salary ',
      child: Text('Salary'),
    ),
    DropdownMenuItem(
      value: 'part time income',
      child: Text('Part time income'),
    ),
    DropdownMenuItem(
      value: 'passive Income',
      child: Text('Passive Income'),
    ),
    DropdownMenuItem(
      value: 'investments Profit',
      child: Text('Investments Profit'),
    ),
    DropdownMenuItem(
      value: 'gifts',
      child: Text('Gifts'),
    ),
    DropdownMenuItem(
      value: 'others',
      child: Text('Others'),
    ),
  ];

//to add alert box to delete

}