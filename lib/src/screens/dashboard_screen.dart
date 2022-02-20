import 'package:digicare/src/blocs/sensor_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../blocs/user_bloc.dart';
import '../models/user_model.dart';

import '../widgets/dashboard/profile/profile_widget.dart';
import '../widgets/dashboard/sensors/sensors.dart';

import '../widgets/dashboard/profile_loading/profile_loading.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Dashboard();
    UserBloc userBloc = Provider.of<UserBloc>(context);
    userBloc.fetchUser(1);
    SensorBloc sensorBloc = Provider.of<SensorBloc>(context);
    sensorBloc.fetchAllSensors(userBloc.jwt);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        elevation: .1,
        backgroundColor: const Color.fromRGBO(49, 87, 110, 1.0),
      ),
      body: StreamBuilder(
        stream: userBloc.userStream,
        builder:
            (BuildContext context, AsyncSnapshot<Future<UserModel>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("LOADING USER"),
            );
          }
          return FutureBuilder(
            future: snapshot.data,
            builder:
                (BuildContext context, AsyncSnapshot<UserModel> userSnapshot) {
              if (!userSnapshot.hasData) {
                return loadingWidgets();
              }

              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  ProfileWidget(userSnapshot.data!),
                  DashboardSensors(),
                ],
                padding: const EdgeInsets.all(10),
              );
            },
          );
        },
      ),
    );
  }

  Widget loadingWidgets() {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Shimmer(
          child: ProfileWidgetLoading(),
          gradient: LinearGradient(colors: <Color>[
            Colors.grey[300]!,
            Colors.grey[50]!,
          ]),
          period: const Duration(seconds: 1),
        ),
        DashboardSensors(),
      ],
      padding: const EdgeInsets.all(10),
    );
  }
}
