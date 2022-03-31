import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../blocs/user_bloc.dart';
import '../models/user_model.dart';
import '../blocs/sensor_bloc.dart';
import '../models/sensor_model.dart';

import '../widgets/dashboard/profile/profile_widget.dart';
import '../widgets/sensors/sensors.dart';

import '../widgets/dashboard/profile_loading/profile_loading.dart';
import '../widgets/dashboard/sensors_loading/sensors_loading.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Dashboard();
    UserBloc userBloc = Provider.of<UserBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        elevation: .1,
        backgroundColor: const Color.fromRGBO(49, 87, 110, 1.0),
      ),
      drawer: getDrawer(userBloc, context),
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
                return ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[loadingProfile()],
                  padding: const EdgeInsets.all(10),
                );
              } else {
                userBloc.id = userSnapshot.data!.id;
                UserModel user = userSnapshot.data!;
                if (user.roles[0] == UserRole.ROLE_PATIENT) {
                  userBloc.patientID = userBloc.id;
                  return ListView(
                    scrollDirection: Axis.vertical,
                    children: patientDashboard(user, context),
                    padding: const EdgeInsets.all(10),
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      profile(user),
                      doctorDashboard(user, context, userBloc)
                    ],
                  );
                }
              }
            },
          );
        },
      ),
    );
  }

  List<Widget> patientDashboard(UserModel user, BuildContext context) {
    return <Widget>[
      profile(user),
      sensors(context),
    ];
  }

  Widget doctorDashboard(
      UserModel user, BuildContext context, UserBloc userBloc) {
    userBloc.fetchPatients(1);

    return StreamBuilder(
      stream: userBloc.patientsStream,
      builder: (BuildContext context,
          AsyncSnapshot<Future<List<UserModel>?>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return FutureBuilder(
          future: snapshot.data,
          builder: (BuildContext context,
              AsyncSnapshot<List<UserModel>?> patientsSnapshot) {
            if (!patientsSnapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<UserModel> patients = patientsSnapshot.data!;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: patients.length,
                  itemBuilder: (context, int index) {
                    return ListTile(
                      title: Text(
                          '${patients[index].firstName} ${patients[index].lastName}'),
                      subtitle: Text("Age: ${patients[index].age}"),
                      onTap: () {
                        userBloc.patientID = patients[index].id;

                        Navigator.pushNamed(
                          context,
                          '/patientdata',
                          arguments: {"patient": patients[index]},
                        );
                      },
                    );
                  },
                  padding: const EdgeInsets.all(10));
            }
          },
        );
      },
    );
    // return <Widget>[
    //   profile(user),
    //   sensors(context),
    // ];
  }

  Drawer getDrawer(UserBloc userBloc, BuildContext context) {
    return Drawer(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          const DrawerHeader(
            child: Text("Hi"),
          ),
          ListTile(
            title: const Text("Logout"),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
        padding: const EdgeInsets.all(5),
      ),
    );
    // UserModel userModel = userBloc.userStream.value;
    /*return Drawer(
      child: StreamBuilder(
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
              List<Widget> children = <Widget>[
                const DrawerHeader(child: Text("Hi")),
              ];

              if (userSnapshot.hasData) {
                // userBloc.id = userSnapshot.data!.id;
                for (UserRole role in userSnapshot.data!.roles) {
                  children.add(Text(role.toString()));
                }
              }
              // children.add(sensors(context));

              return ListView(
                scrollDirection: Axis.vertical,
                children: children,
                padding: const EdgeInsets.all(5),
              );
            },
          );
        },
      ),
    );*/
  }

  Widget profile(UserModel user) {
    return ProfileWidget(user);
  }

  Widget sensors(BuildContext context) {
    SensorBloc sensorBloc = Provider.of<SensorBloc>(context);

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
          },
        );
      },
    );
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
