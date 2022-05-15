import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'stream_text_field.dart';
import '../../blocs/assessment_bloc.dart';
import '../../blocs/user_bloc.dart';

class NewAssessment extends StatelessWidget {
  final int _patientID;

  NewAssessment(this._patientID);

  @override
  Widget build(BuildContext context) {
    AssessmentBloc assessmentBloc = Provider.of<AssessmentBloc>(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          StreamTextField(
            hintText: "Tap to add notes",
            labelText: "Notes",
            stream: assessmentBloc.notesStream,
            onChanged: assessmentBloc.changeNotes,
            minLines: 2,
            maxLines: 5,
          ),
          StreamTextField(
            hintText: "Tap to add condition",
            labelText: "Condition",
            stream: assessmentBloc.conditionStream,
            onChanged: assessmentBloc.changeCondition,
            minLines: 2,
            maxLines: 5,
          ),
          StreamTextField(
            hintText: "Tap to add recommendations",
            labelText: "Recommendations",
            stream: assessmentBloc.recommendationsStream,
            onChanged: assessmentBloc.changeRecommendations,
            minLines: 2,
            maxLines: 5,
          ),
          StreamTextField(
            hintText: "Tap to add caregiver instrucitons",
            labelText: "CG Instructions",
            stream: assessmentBloc.cgInstrStream,
            onChanged: assessmentBloc.changeCgInstr,
            minLines: 2,
            maxLines: 5,
          ),
          StreamTextField(
            hintText: "Describe the data here",
            labelText: "Data description",
            stream: assessmentBloc.dataDescStream,
            onChanged: assessmentBloc.changeDataDesc,
            minLines: 2,
            maxLines: 5,
          ),
          submitButton(assessmentBloc, context),
        ],
      ),
    );
  }

  Widget submitButton(AssessmentBloc bloc, BuildContext context) {
    return StreamBuilder(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: snapshot.hasData
              ? () async {
                  await bloc.submit(
                    Provider.of<UserBloc>(context, listen: false).jwt,
                    _patientID,
                  );
                  Fluttertoast.showToast(
                    msg: "Assessment uploaded",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                }
              : null,
          child: const Text(
            'Upload Assessment',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}
