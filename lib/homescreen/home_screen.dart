import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymap/homescreen/bottom_navigatior_app.dart';
import 'package:moneymap/homescreen/screens/first_screen.dart';
import 'package:moneymap/homescreen/screens/search/search_base.dart';
import 'package:moneymap/homescreen/screens/settings_screen.dart';
import 'package:moneymap/homescreen/screens/statistics_screen.dart';
import 'package:moneymap/homescreen/screens/widgets/global_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static ValueNotifier<int> selectedBottomNotifier = ValueNotifier(0);
  final _pages = [
    const FirstScreen(),
    const StatisticsScreen(),
    const SettingsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigatorMoneyMap(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
        centerTitle: true,
        title: G().textOfMap(text: "Money Map", size: 28, color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => SearchAndView(),
                  ));
                  // showSearch(context: context, delegate: SearchAndView());
                },
                icon: const Icon(
                  Icons.manage_search,
                  color: Color.fromARGB(255, 232, 225, 233),
                  size: 30,
                )),
          )
        ],
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: selectedBottomNotifier,
        builder: (context, int updatedIndex, _) {
          return _pages[updatedIndex];
        },
      )),
    );
  }
}
