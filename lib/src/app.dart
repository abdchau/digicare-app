import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'blocs/login_bloc.dart';
import 'blocs/user_bloc.dart';
import 'blocs/sensor_bloc.dart';
import 'blocs/signup_bloc.dart';
import 'blocs/assessment_bloc.dart';

import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/patient_display_screen.dart';
import 'screens/sensor_display_screen.dart';
import 'screens/add_doctor_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<UserBloc>(
      create: (BuildContext context) => UserBloc(),
      child: Provider<SensorBloc>(
        create: (BuildContext context) => SensorBloc(),
        child: MaterialApp(
          title: 'Digicare',
          onGenerateRoute: routes,
          theme: ThemeData(
            primaryColor: const Color.fromRGBO(0, 109, 119, 1.0),
          ),
        ),
      ),
    );
  }

  MaterialPageRoute routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return Provider<LoginBloc>(
            create: (BuildContext context) => LoginBloc(),
            child: LoginScreen(),
          );
        },
      );
    } else if (settings.name == '/dashboard') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          UserBloc userBloc = Provider.of<UserBloc>(context);
          userBloc.fetchUser(1);
          SensorBloc sensorBloc = Provider.of<SensorBloc>(context);
          sensorBloc.fetchSensors(userBloc.jwt);
          return DashboardScreen();
        },
      );
    } else if (settings.name == '/add_doctors') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return AddDoctorScreen();
        },
      );
    } else if (settings.name == '/signup') {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          print('helo');
          return Provider<SignupBloc>(
            create: (BuildContext context) => SignupBloc(),
            child: SignupScreen(),
          );
        },
      );
    } else if (settings.name!.substring(0, 11).compareTo('/sensordata') == 0) {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          UserBloc userBloc = Provider.of<UserBloc>(context);
          SensorBloc sensorBloc = Provider.of<SensorBloc>(context);
          print(settings.name!.substring(12));
          sensorBloc.fetchReadings(
            <String, dynamic>{
              'jwt': userBloc.jwt,
              'patientID': userBloc.patientID,
              'sensorID': int.parse(settings.name!.substring(12)),
            },
          );

          return SensorDisplayScreen();
        },
      );
    } else {
      final Map<String, dynamic> rcvdData =
          settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return Provider<AssessmentBloc>(
            create: (BuildContext context) => AssessmentBloc(),
            child: PatientDisplayScreen(rcvdData['patient']),
          );
        },
      );
    }
  }
}
