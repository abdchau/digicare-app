import 'package:flutter/material.dart';

import '../../../models/sensor_model.dart';

class SensorItem extends StatelessWidget {
  SensorModel sensorModel;
  IconData icon;

  SensorItem(this.sensorModel, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration:
          const BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/sensordata/${sensorModel.id}");
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
              child: Text(sensorModel.dataDesc,
                  style: const TextStyle(fontSize: 18.0, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

Widget loadingDashItem() {
  return Container(
    margin: const EdgeInsets.all(8.0),
    decoration: const BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
    child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        verticalDirection: VerticalDirection.down,
        children: const <Widget>[
          SizedBox(height: 50.0),
          SizedBox(height: 40),
          SizedBox(height: 20.0),
          SizedBox(height: 30),
        ],
      ),
    ),
  );
}
