import 'package:digicare/src/models/assessment_model.dart';
import 'package:rxdart/rxdart.dart';

import '../mixins/validators.dart';
import '../resources/rest_api.dart';

class AssessmentBloc with Validator {
  final _api = RestAPI();

  final _notes = BehaviorSubject<String>();
  final _condition = BehaviorSubject<String>();
  final _recommendations = BehaviorSubject<String>();
  final _cgInstr = BehaviorSubject<String>();
  final _dataDesc = BehaviorSubject<String>();

  Function(String) get changeNotes => _notes.sink.add;
  Function(String) get changeCondition => _condition.sink.add;
  Function(String) get changeRecommendations => _recommendations.sink.add;
  Function(String) get changeCgInstr => _cgInstr.sink.add;
  Function(String) get changeDataDesc => _dataDesc.sink.add;

  Stream<String> get notesStream => _notes.stream.transform(validateText);
  Stream<String> get conditionStream =>
      _condition.stream.transform(validateText);
  Stream<String> get recommendationsStream =>
      _recommendations.stream.transform(validateText);
  Stream<String> get cgInstrStream => _cgInstr.stream.transform(validateText);

  Stream<String> get dataDescStream => _dataDesc.stream.transform(validateText);

  CombineLatestStream<dynamic, bool> get submitValid =>
      CombineLatestStream.combine5(
        notesStream,
        conditionStream,
        recommendationsStream,
        cgInstrStream,
        dataDescStream,
        (n, c, r, cg, d) => true,
      );

  Future<void> submit(String jwt, int patientID) async {
    print("Uploading assessment..");
    await _api.uploadAssessment(
      jwt,
      AssessmentModel(
        -1,
        _notes.value,
        _condition.value,
        _recommendations.value,
        _cgInstr.value,
        _dataDesc.value,
        patientID,
      ),
    );
  }
}
