import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../blocs/user_bloc.dart';
import '../models/user_model.dart';
import '../blocs/sensor_bloc.dart';
import '../models/sensor_model.dart';

import '../widgets/dashboard/profile/profile_widget.dart';
import '../widgets/dashboard/sensors/sensors.dart';

import '../widgets/dashboard/profile_loading/profile_loading.dart';
import '../widgets/dashboard/sensors_loading/sensors_loading.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Dashboard();
    UserBloc userBloc = Provider.of<UserBloc>(context);
    userBloc.fetchUser(1);
    SensorBloc sensorBloc = Provider.of<SensorBloc>(context);
    sensorBloc.fetchSensors(userBloc.jwt);

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
              List<Widget> children = <Widget>[];

              if (!userSnapshot.hasData) {
                children.add(loadingProfile());
              } else {
                children.add(profile(userSnapshot.data!));
              }
              children.add(sensors(sensorBloc));

              return ListView(
                scrollDirection: Axis.vertical,
                children: children,
                padding: const EdgeInsets.all(10),
              );
            },
          );
        },
      ),
    );
  }

  Widget profile(UserModel user) {
    return ProfileWidget(user);
  }

  Widget sensors(SensorBloc sensorBloc) {
    return StreamBuilder(
        stream: sensorBloc.sensorsStream,
        builder: (BuildContext context,
            AsyncSnapshot<Future<List<SensorModel>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("LOADING USER"),
            );
          }
          return FutureBuilder(
              future: snapshot.data,
              builder: (BuildContext context,
                  AsyncSnapshot<List<SensorModel>> sensorsSnapshot) {
                if (!sensorsSnapshot.hasData) {
                  return loadingSensors();
                }
                return DashboardSensors(sensorsSnapshot.data!);
              });
        });
  }

  Widget loadingProfile() {
    return Shimmer(
      child: ProfileWidgetLoading(),
      gradient: LinearGradient(colors: <Color>[
        Colors.grey[300]!,
        Colors.grey[50]!,
      ]),
      period: const Duration(seconds: 1),
    );
  }

  Widget loadingSensors() {
    return DashboardSensorsLoading();
  }
}
