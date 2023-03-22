import 'package:flutter/material.dart';
import 'package:moneymap/homescreen/screens/widgets/global_widgets.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              G().textOfMap(text: "About Us ", size: 20, color: Colors.white),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 160,
                      child: Image.asset("Assets/images/logo_wo_bg.png"),
                    ),
                  ],
                ),
                const Text(
                  'Version 1.0.1',
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 160,
                      child: Image.asset("Assets/images/moneyMapLogo.png"),
                    ),
                  ],
                ),
                const Text(
                    'Created by Akhil G K, as a first mobile application '),
                const Text('using flutter.')
              ],
            ),
          ),
        ));
  }
}
