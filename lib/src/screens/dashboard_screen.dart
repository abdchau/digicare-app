import 'package:digicare/src/widgets/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/user_bloc.dart';
import '../models/user_model.dart';
import '../widgets/profile_widget.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Dashboard();
    UserBloc bloc = Provider.of<UserBloc>(context);
    bloc.fetchUser(1);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        elevation: .1,
        backgroundColor: const Color.fromRGBO(49, 87, 110, 1.0),
      ),
      body: ProfileWidget(), //userWidget(bloc),
    );
  }
}
