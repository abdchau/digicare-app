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
            AsyncSnapshot<Future<List<ReadingModel>?>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return FutureBuilder(
              future: snapshot.data,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ReadingModel>?> readingsSnapshot) {
                if (readingsSnapshot.hasError) {
                  return AlertDialog(
                    title: const Text("No readings for this sensor"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      )
                    ],
                  );
                } else if (!readingsSnapshot.hasData) {
                  print(readingsSnapshot.data);
                  return const Center(child: CircularProgressIndicator());
                }

                print("${readingsSnapshot.data} DINGDNOG");

                return ListView(
                  children: getReadingTiles(readingsSnapshot.data!),
                  padding: const EdgeInsets.all(10),
                );
              });
        },
      ),
    );
  }

  List<Widget> getReadingTiles(List<ReadingModel> readings) {
    var ret = <Widget>[];
    for (ReadingModel reading in readings) {
      ret.add(
        Card(
          child: ListTile(
            title: Text("${reading.value}"),
            subtitle: Text("${reading.timestamp}"),
          ),
        ),
      );
    }

    return ret;
  }
}
