import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/sensor_bloc.dart';
import '../models/reading_model.dart';

class SensorDisplayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SensorBloc sensorBloc = Provider.of<SensorBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor'),
        elevation: .1,
        backgroundColor: const Color.fromRGBO(49, 87, 110, 1.0),
      ),
      body: StreamBuilder(
        stream: sensorBloc.readingsStream,
        builder: (BuildContext context,
            AsyncSnapshot<Future<List<ReadingModel>>> snapshot) {
          return FutureBuilder(
              future: snapshot.data,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ReadingModel>> readingsSnapshot) {
                return ListView(
                  children: [
                    Card(
                      child: ListTile(
                        title: Text("{$readingsSnapshot.data}"),
                      ),
                    ),
                    const Card(
                      child: ListTile(
                        title: Text("List Item 2"),
                      ),
                    ),
                    const Card(
                        child: ListTile(
                      title: Text("List Item 3"),
                    )),
                  ],
                  padding: const EdgeInsets.all(10),
                );
              });
        },
      ),
    );
  }
}
