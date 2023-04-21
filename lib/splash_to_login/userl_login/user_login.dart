// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymap/homescreen/screens/widgets/global_widgets.dart';
import 'package:moneymap/providers/login_provider.dart';
import 'package:provider/provider.dart';

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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'Assets/images/moneyMapLogo.png',
                    height: 80,
                  ),
                ],
              ),
              Image.asset('Assets/images/LoginImg.png'),
              Row(
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
              ),
              TextFormField(
                controller: userName,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 20,
                  ),

                  //to skip name adding option
                  ElevatedButton(
                      onPressed: () {
                        Provider.of<LoginProvider>(context, listen: false)
                            .skipLogin(context);
                      },
                      child: buttonStyle('Skip')),

                  //to save name adding option

                  ElevatedButton(
                      onPressed: () {
                        Provider.of<LoginProvider>(context, listen: false)
                            .saveLogin(context, userName.text);
                      },
                      child: buttonStyle('Save')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buttonStyle(String caption) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: G().textOfMap(text: caption, size: 18, color: Colors.white),
    );
  }
}
