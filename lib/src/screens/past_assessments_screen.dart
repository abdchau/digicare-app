import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/assessment_model.dart';
import '../blocs/assessment_bloc.dart';

class PastAssessmentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssessmentBloc assessmentBloc = Provider.of<AssessmentBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Past Assessments"),
      ),
      body: StreamBuilder(
        stream: assessmentBloc.assessmentsStream,
        builder: (BuildContext context,
            AsyncSnapshot<Future<List<AssessmentModel>?>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return FutureBuilder(
            future: snapshot.data,
            builder: (BuildContext context,
                AsyncSnapshot<List<AssessmentModel>?> assessmentsSnapshot) {
              if (assessmentsSnapshot.hasError) {
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, index) {
                    return ListTile(
                      title: const Text("No past assessments"),
                      subtitle: const Text("Tap to add assessments"),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      trailing: const Icon(Icons.add),
                    );
                  },
                );
              } else if (!assessmentsSnapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<AssessmentModel> assessments = assessmentsSnapshot.data!;
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                shrinkWrap: true,
                itemCount: assessments.length,
                itemBuilder: (context, int index) {
                  return Column(
                    children: [
                      Dismissible(
                        key: Key(assessments[index].id.toString()),
                        onDismissed: (DismissDirection direction) {
                          print("deletion not yet supported");

                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text(
                          //         '${assessments[index].dataDesc} ${assessments[index].cgInstr} dismissed'),
                          //   ),
                          // );
                        },
                        background: Container(color: Colors.red),
                        child: ListTile(
                          title: Text('${assessments[index].dataDesc}'),
                          subtitle: Text("${assessments[index].timestamp}"),
                          onTap: () {
                            print(assessments[index].dataDesc);
                          },
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
