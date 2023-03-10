import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moneymap/homescreen/screens/settings/about_us.dart';
import 'package:moneymap/homescreen/screens/settings/accountinfo.dart';
import 'package:moneymap/homescreen/screens/settings/customer_care.dart';
import 'package:moneymap/homescreen/screens/settings/terms_and_conditions.dart';
import 'package:moneymap/homescreen/screens/widgets/global_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              G().textOfMap(
                text: "Settings",
                size: 24,
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
              G().sBox(h: 15),
              Row(
                children: [
                  G().textOfMap(
                      color: Colors.black87, size: 20, text: 'Profile'),
                ],
              ),
              G().sBox(h: 10),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.purple)),
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: G().textOfMap(
                    text: 'Account Information',
                    size: 18,
                    color: Colors.black87),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AccountInfo(),
                  ));
                },
              ),
              G().sBox(h: 20),
              Row(
                children: [
                  G().textOfMap(
                      color: Colors.black87, size: 20, text: 'Profile')
                ],
              ),
              G().sBox(h: 15),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.purple)),
                leading: CircleAvatar(
                  child: Icon(Icons.info),
                ),
                title: G().textOfMap(
                    text: 'About Us', size: 18, color: Colors.black87),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AboutUs(),
                  ));
                },
              ),
              G().sBox(h: 10),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.purple)),
                leading: CircleAvatar(
                  child: Icon(Icons.contact_mail),
                ),
                title: G().textOfMap(
                    text: 'Customer Care', size: 18, color: Colors.black87),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CustomerCare(),
                  ));
                },
              ),
              G().sBox(h: 10),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.purple)),
                leading: CircleAvatar(
                  child: Icon(Icons.share),
                ),
                title: G()
                    .textOfMap(text: 'Share', size: 18, color: Colors.black87),
              ),
              G().sBox(h: 10),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.purple)),
                leading: CircleAvatar(
                  child: Icon(Icons.note),
                ),
                title: G().textOfMap(
                    text: 'Terms&Conditions', size: 18, color: Colors.black87),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TermsAndConditions(),
                  ));
                },
              ),
              G().sBox(h: 10),
            ],
          ),
        ),
      ),
    );
  }
}
