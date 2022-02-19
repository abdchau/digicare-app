import 'package:flutter/material.dart';

Widget makeDashboardItem(String title, IconData icon, BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    decoration: const BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
    child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/dashboard/sensordata");
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          const SizedBox(height: 50.0),
          Center(
              child: Icon(
            icon,
            size: 40.0,
            color: Colors.black,
          )),
          const SizedBox(height: 20.0),
          Center(
            child: Text(title,
                style: const TextStyle(fontSize: 18.0, color: Colors.black)),
          ),
        ],
      ),
    ),
  );
}
