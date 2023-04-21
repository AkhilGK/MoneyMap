import 'package:flutter/material.dart';
import 'package:moneymap/homescreen/screens/widgets/global_widgets.dart';
import 'package:moneymap/providers/firstscreen_provider.dart';
import 'package:provider/provider.dart';

import '../bottom_nav/home_screen.dart';

class AccountInfo extends StatelessWidget {
  AccountInfo({super.key});
  final TextEditingController _userNameInSetting = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: G().textOfMap(
              text: "Account Information ", size: 20, color: Colors.white),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  G().sBox(h: 15),
                  Row(
                    children: [
                      const Icon(Icons.edit),
                      const SizedBox(
                        width: 20,
                      ),
                      G().textOfMap(
                          text: "Add or change name",
                          size: 22,
                          color: Colors.purple)
                    ],
                  ),
                  G().sBox(h: 15),
                  TextFormField(
                    controller: _userNameInSetting,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Name',
                      labelText: 'User',
                    ),
                  ),
                  G().sBox(h: 15),
                  ElevatedButton(
                      onPressed: () {
                        Provider.of<FirstScreenProvider>(context, listen: false)
                            .changeName(_userNameInSetting.text);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (Route<dynamic> route) => false,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: const Text('Save'))
                ],
              ),
            ),
          ),
        ));
  }

  final snackBar = const SnackBar(
    content: Text('Saved Changes!'),
    backgroundColor: (Color.fromARGB(195, 223, 91, 212)),
  );
}
