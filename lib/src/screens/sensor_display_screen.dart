import 'package:flutter/material.dart';

class SensorDisplayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor'),
        elevation: .1,
        backgroundColor: const Color.fromRGBO(49, 87, 110, 1.0),
      ),
      body: ListView(
        children: const [
          Card(
              child: ListTile(
            title: Text("List Item 1"),
          )),
          Card(
            child: ListTile(
              title: Text("List Item 2"),
            ),
          ),
          Card(
              child: ListTile(
            title: Text("List Item 3"),
          )),
        ],
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}
