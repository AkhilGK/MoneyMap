import 'package:flutter/material.dart';
import 'package:moneymap/homescreen/screens/settings/about_us.dart';
import 'package:moneymap/homescreen/screens/settings/accountinfo.dart';
import 'package:moneymap/homescreen/screens/settings/customer_care.dart';
import 'package:moneymap/homescreen/screens/widgets/global_widgets.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                G().textOfMap(color: Colors.black87, size: 20, text: 'Profile'),
              ],
            ),
            G().sBox(h: 10),
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.purple)),
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: G().textOfMap(
                  text: 'Account Information', size: 18, color: Colors.black87),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AccountInfo(),
                ));
              },
            ),
            G().sBox(h: 20),
            Row(
              children: [
                G().textOfMap(color: Colors.black87, size: 20, text: 'Profile')
              ],
            ),
            G().sBox(h: 15),
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.purple)),
              leading: const CircleAvatar(
                child: Icon(Icons.info),
              ),
              title: G()
                  .textOfMap(text: 'About Us', size: 18, color: Colors.black87),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AboutUs(),
                ));
              },
            ),
            G().sBox(h: 10),
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.purple)),
              leading: const CircleAvatar(
                child: Icon(Icons.contact_mail),
              ),
              title: G().textOfMap(
                  text: 'Customer Care', size: 18, color: Colors.black87),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CustomerCare(),
                ));
              },
            ),
            G().sBox(h: 10),
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.purple)),
              leading: const CircleAvatar(
                child: Icon(Icons.share),
              ),
              onTap: () {
                Share.share(
                    'https://play.google.com/store/apps/details?id=in.akbromz.money_map');
              },
              title:
                  G().textOfMap(text: 'Share', size: 18, color: Colors.black87),
            ),
            G().sBox(h: 10),
            G().sBox(h: 10),
          ],
        ),
      ),
    );
  }
}
