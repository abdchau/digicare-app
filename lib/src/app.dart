import 'package:digicare/src/screens/data_display_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';
import 'blocs/login_bloc.dart';
import 'blocs/user_bloc.dart';
import 'blocs/sensor_bloc.dart';
import 'screens/dashboard_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<UserBloc>(
      create: (BuildContext context) => UserBloc(),
      child: MaterialApp(
        title: 'Digicare',
        onGenerateRoute: routes,
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
          return Provider<SensorBloc>(
            create: (BuildContext context) => SensorBloc(),
            child: DashboardScreen(),
          );
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          return DataDisplayScreen();
        },
      );
    }
  }
}
