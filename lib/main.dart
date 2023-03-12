//MONEY MAP
//MONEY MAP
//A personal money tracking app

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transactions_functions.dart';
import 'package:moneymap/homescreen/screens/add_categories/db_categories/categories_db_functions.dart';
import 'package:moneymap/homescreen/screens/add_categories/db_categories/categories_db_model.dart';
import 'package:moneymap/splash_to_login/splash/splash_screen.dart';

import 'homescreen/screens/add transactions/db_transactions/transaction_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //hive
  await Hive.initFlutter();
  await Hive.openBox('onboarding_check');

  //income categories

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const MoneyMap());
//to notify category list
  refreshUI();
  alertUi();
}

bool skipped = false; //to check onboardings skipped
bool loginSkipped = false; //to check login skipped

class MoneyMap extends StatelessWidget {
  const MoneyMap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 234, 218, 235),
          primarySwatch: Colors.purple,
          fontFamily: GoogleFonts.dmSans().fontFamily),
      home: const SplashScreen(),
    );
  }
}
