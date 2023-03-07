import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
              children: [
                G().sBox(h: 15),
                Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(
                      width: 20,
                    ),
                    G().textOfMap(
                        text: "Add or change name",
                        size: 22,
                        color: Colors.purple)
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
