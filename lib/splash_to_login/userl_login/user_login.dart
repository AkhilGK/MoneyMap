import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymap/homescreen/home_screen.dart';
import 'package:moneymap/homescreen/screens/widgets/global_widgets.dart';
import 'package:moneymap/main.dart';

class UserLogin extends StatelessWidget {
  UserLogin({super.key});
  TextEditingController userName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'Assets/images/moneyMapLogo.png',
                      height: 80,
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 4, child: Image.asset('Assets/images/LoginImg.png')),
              Expanded(
                  child: Row(
                //name row
                children: [
                  Text(
                    " Your name",
                    style: GoogleFonts.dmSans(
                        fontSize: 20,
                        color: Colors.purple,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
              Expanded(
                  child: TextFormField(
                controller: userName,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              )),
              SizedBox(
                height: 8,
              ),
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),

                      //to skip name adding option
                      ElevatedButton(
                          onPressed: () {
                            loginSkipped = true;
                            Hive.box('onboarding_check')
                                .put('LoginSkipped', loginSkipped);
                            Hive.box('onboarding_check').put('userName',
                                'User'); //added user name to data base
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: G().textOfMap(
                                text: "Skip", size: 18, color: Colors.white),
                          )),

                      //to save name adding option

                      ElevatedButton(
                          onPressed: () {
                            loginSkipped = true;
                            if (userName.text == '') {
                              userName.text = 'User';
                            }
                            Hive.box('onboarding_check').put('userName',
                                userName.text); //added user name to data base
                            Hive.box('onboarding_check').put('LoginSkipped',
                                loginSkipped); //confirm the page wont appear again at restart
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: G().textOfMap(
                                text: "Save", size: 18, color: Colors.white),
                          )),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
