import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymap/homescreen/screens/first_screen.dart';
import 'package:moneymap/homescreen/screens/widgets/global_widgets.dart';

class AccountInfo extends StatelessWidget {
  AccountInfo({super.key});
  TextEditingController _userNameInSetting = TextEditingController();
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
                      SizedBox(
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
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Name',
                      labelText: 'User',
                    ),
                  ),
                  G().sBox(h: 15),
                  ElevatedButton(
                      onPressed: () {
                        Hive.box('onboarding_check')
                            .put('userName', _userNameInSetting.text);
                        const FirstScreen();
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
