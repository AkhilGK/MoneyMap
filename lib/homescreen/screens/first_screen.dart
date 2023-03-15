import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymap/homescreen/screens/search/search_base.dart';
import 'package:moneymap/homescreen/screens/widgets/first_screen_widgets.dart';
import 'package:moneymap/homescreen/screens/widgets/flipcard.dart';
import 'package:moneymap/homescreen/screens/widgets/global_widgets.dart';
import 'add transactions/add_transaction.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final String userNameFromDB = Hive.box('onboarding_check').get('userName');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            //main column
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  moneyMapText(
                      text: 'Hi $userNameFromDB ,',
                      size: 28,
                      color: const Color.fromRGBO(177, 103, 190, 1),
                      fontWeight: FontWeight.bold),
                ],
              ),
              Row(
                children: [
                  moneyMapText(
                      text: 'What expenses did you make today?',
                      size: 20,
                      color: Colors.black54),
                ],
              ),
              sbox(),
              sbox(),
              FirstFlipCard(),
              addButton(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  G().textOfMap(
                      text: "Recent Transactions",
                      size: 20,
                      color: Colors.black),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => const SearchAndView(),
                      ));
                    },
                    child: const Text(
                      'See all   ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.purple,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              FirstScreenWidget().listtileRecent(context)
            ],
          ),
        ),
      ),
    );
  }

//A custome text widget
  Widget moneyMapText({
    required String text,
    required double size,
    required Color color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Text(
      text,
      style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
    );
  }

//A sized box
  Widget sbox() {
    return const SizedBox(
      height: 10,
    );
  }

  Widget addButton(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        const SizedBox(
          width: double.infinity,
          height: 110,
        ),
        Positioned(
          bottom: 30,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topRight: Radius.circular(50)),
              color: Color.fromARGB(255, 228, 216, 225),
            ),
            width: 200,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: moneyMapText(
                  text: "Add a transaction",
                  size: 20,
                  color: Colors.purple,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.purple,
          ),
          width: 60,
          height: 60,
          child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    // refreshUI();
                    return const AddTransaction();
                  },
                ));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white70,
              )),
        ),
      ],
    );
  }
}
