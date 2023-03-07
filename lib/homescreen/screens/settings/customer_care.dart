import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moneymap/homescreen/screens/widgets/global_widgets.dart';

class CustomerCare extends StatefulWidget {
  const CustomerCare({super.key});

  @override
  State<CustomerCare> createState() => _CustomerCareState();
}

class _CustomerCareState extends State<CustomerCare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: G()
              .textOfMap(text: "Customer Care ", size: 20, color: Colors.white),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                G().sBox(h: 15),
                ElevatedButton(onPressed: () {}, child: Text("Mail Us Now"))
              ],
            ),
          ),
        ));
  }
}
