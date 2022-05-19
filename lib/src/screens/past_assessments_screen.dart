import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'assessment_detail_screen.dart';

import '../models/user_model.dart';
import '../models/assessment_model.dart';

import '../blocs/assessment_bloc.dart';
import '../blocs/user_bloc.dart';

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
                      subtitle: Text(
                          Provider.of<UserBloc>(context).user.roles[0] ==
                                  UserRole.ROLE_DOCTOR
                              ? "Tap to add assessments"
                              : "Ask your doctor to make an assessment"),
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
              return MediaQuery.of(context).size.width > 500
                  ? WideLayout(assessments)
                  : NarrowLayout(assessments);
            },
          );
        },
      ),
    );
  }
}

class WideLayout extends StatefulWidget {
  final List<AssessmentModel> _assessments;

  WideLayout(this._assessments);

  @override
  State<WideLayout> createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  AssessmentModel? _assessment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _AssessmentList(
            widget._assessments,
            (AssessmentModel assessment) {
              setState(() {
                _assessment = assessment;
              });
            },
          ),
        ),
        Expanded(
          flex: 3,
          child: _assessment == null
              ? const Placeholder()
              : AssessmentDetailScreen(_assessment!),
        ),
      ],
    );
  }
}

class NarrowLayout extends StatelessWidget {
  final List<AssessmentModel> _assessments;

  NarrowLayout(this._assessments);

  @override
  Widget build(BuildContext context) {
    return _AssessmentList(
      _assessments,
      (AssessmentModel assessment) {
        print(assessment.dataDesc);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Details"),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                body: AssessmentDetailScreen(assessment),
              );
            },
          ),
        );
      },
    );
  }
}

class _AssessmentList extends StatelessWidget {
  final List<AssessmentModel> _assessments;
  final void Function(AssessmentModel) _onAssessmentTapCallback;

  _AssessmentList(this._assessments, this._onAssessmentTapCallback);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      itemCount: _assessments.length,
      itemBuilder: (context, int index) {
        return Column(
          children: [
            Dismissible(
              key: Key(_assessments[index].id.toString()),
              onDismissed: (DismissDirection direction) {
                print("deletion not yet supported");

                // ScaffoldMessenger.of(context).showSnackBar(
                //   SnackBar(
                //     content: Text(
                //         '${_assessments[index].dataDesc} ${_assessments[index].cgInstr} dismissed'),
                //   ),
                // );
              },
              background: Container(color: Colors.red),
              child: ListTile(
                title: Text('${_assessments[index].dataDesc}'),
                subtitle: Text("${_assessments[index].timestamp}"),
                onTap: () => _onAssessmentTapCallback(_assessments[index]),
              ),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
