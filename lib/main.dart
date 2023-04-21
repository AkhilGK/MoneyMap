//MONEY MAP
//MONEY MAP
//A personal money tracking app

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymap/homescreen/screens/add%20transactions/db_transactions/transactions_functions.dart';
import 'package:moneymap/homescreen/screens/add_categories/db_categories/categories_db_functions.dart';
import 'package:moneymap/homescreen/screens/add_categories/db_categories/categories_db_model.dart';
import 'package:moneymap/providers/add_transaction_provider.dart';
import 'package:moneymap/providers/category_provider.dart';
import 'package:moneymap/providers/edit_delete_provider.dart';
import 'package:moneymap/providers/firstscreen_provider.dart';
import 'package:moneymap/providers/login_provider.dart';
import 'package:moneymap/providers/onboarding_provider.dart';
import 'package:moneymap/providers/search_provider.dart';
import 'package:moneymap/providers/transaction_provider.dart';
import 'package:moneymap/splash_to_login/splash/splash_screen.dart';
import 'package:provider/provider.dart';
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
  // predefCategory();
  // refreshUI();
  // alertUi();
}

class MoneyMap extends StatelessWidget {
  const MoneyMap({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OnboardingProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => FirstScreenProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => AddtransactionProvider()),
        ChangeNotifierProvider(create: (context) => EditProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 234, 218, 235),
            primarySwatch: Colors.purple,
            fontFamily: GoogleFonts.dmSans().fontFamily),
        home: const SplashScreen(),
      ),
    );
  }
}
