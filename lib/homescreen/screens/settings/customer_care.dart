import 'package:flutter/material.dart';
import 'package:moneymap/homescreen/screens/widgets/global_widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomerCare extends StatelessWidget {
  const CustomerCare({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:
              G().textOfMap(text: "Contact Us ", size: 20, color: Colors.white),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // G().sBox(h: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: ElevatedButton(
                          onPressed: () {
                            launchUrlString('mailto:nanohardbro@gmail.com');
                          },
                          child: const Text("Mail Us Now")),
                    ),
                  ],
                ),
                SizedBox(
                    width: 120,
                    child: Image.asset('Assets/images/moneyMapLogo.png')),
              ],
            ),
          ),
        ));
  }
}
