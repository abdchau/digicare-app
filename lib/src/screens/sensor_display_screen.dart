import 'package:flutter/material.dart';

class SensorDisplayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const <Widget>[
          Text("This is the data display screen"),
          Icon(Icons.account_circle),
        ],
      ),
    );
  }
}
