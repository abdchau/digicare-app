import 'package:flutter/material.dart';

import '../../../models/sensor_model.dart';
import 'dashboard_card.dart';

class DashboardSensors extends StatelessWidget {
  late List<SensorModel> sensors;

  DashboardSensors(this.sensors);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
      child: GridView.count(
        primary: false,
        shrinkWrap: true,
        crossAxisCount: 2,
        padding: const EdgeInsets.all(3.0),
        children: getDashboardItems(context),
      ),
    );
  }

  List<Widget> getDashboardItems(BuildContext context) {
    List<Widget> children = <Widget>[];
    for (SensorModel sensor in sensors) {
      children.add(
          makeDashboardItem(sensor.dataDesc, Icons.health_and_safety, context));
    }

    return children;
  }
}
