import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../blocs/user_bloc.dart';
import '../models/user_model.dart';
import '../widgets/dashboard/profile/profile_widget.dart';
import '../widgets/dashboard/sensors/user_data.dart';

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
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          ProfileWidget(),
          UserData(),
        ],
        padding: EdgeInsets.all(10),
      ),
    );
  }

  List<Widget> getchildren(int num) {
    return <Widget>[ProfileWidget(), UserData()];
    List<Widget> list = [];
    for (int i = 0; i < num; i++) {
      list.add(
        Card(
          child: ListTile(
            title: Text("List Item $i"),
          ),
        ),
      );
    }
    return list;
  }
}
