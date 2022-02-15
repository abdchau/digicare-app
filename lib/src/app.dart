import 'package:digicare/src/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/login_screen.dart';
// import 'blocs/login_provider.dart';
import 'blocs/login_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<LoginBloc>(
      create: (BuildContext context) => LoginBloc(),
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
          return LoginScreen();
        },
      );
    } else {
      return MaterialPageRoute(builder: (BuildContext context) {
        return DashboardScreen();
      });
    }
  }
}
