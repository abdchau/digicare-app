import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../blocs/user_bloc.dart';
import '../../models/user_model.dart';

class DoctorsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DoctorsTabState();
  }
}

class DoctorsTabState extends State<DoctorsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    UserBloc userBloc = Provider.of<UserBloc>(context);
    userBloc.fetchDoctors(1);

    return StreamBuilder(
      stream: userBloc.doctorsStream,
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
              AsyncSnapshot<List<UserModel>?> doctorsSnapshot) {
            if (!doctorsSnapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<UserModel> doctors = doctorsSnapshot.data!;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: doctors.length,
                  itemBuilder: (context, int index) {
                    return Dismissible(
                      key: Key(doctors[index].cnic),
                      onDismissed: (DismissDirection direction) {
                        userBloc.revokeDoctorPermission(doctors[index].id);
                        setState(() {
                          doctors.removeAt(index);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                '${doctors[index].firstName} ${doctors[index].lastName} dismissed'),
                          ),
                        );
                      },
                      background: Container(color: Colors.red),
                      child: ListTile(
                        title: Text(
                            '${doctors[index].firstName} ${doctors[index].lastName}'),
                        subtitle: Text("Age: ${doctors[index].age}"),
                        onTap: () {
                          print(doctors[index].firstName);
                        },
                      ),
                    );
                  },
                  padding: const EdgeInsets.all(10));
            }
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
