import 'package:flutter/material.dart';
import 'dashboard_card.dart';

class UserData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
      child: GridView.count(
        primary: false,
        shrinkWrap: true,
        crossAxisCount: 2,
        padding: const EdgeInsets.all(3.0),
        children: <Widget>[
          makeDashboardItem("SPO2", Icons.health_and_safety, context),
          makeDashboardItem(
              "Heart Rate", Icons.health_and_safety_outlined, context),
          makeDashboardItem("ECG", Icons.health_and_safety_sharp, context),
          makeDashboardItem(
              "Blood Pressure", Icons.health_and_safety_rounded, context),
          makeDashboardItem("Alphabet", Icons.alarm, context),
          makeDashboardItem("Alphabet", Icons.alarm, context)
        ],
      ),
    );
  }
}
