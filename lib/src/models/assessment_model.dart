class AssessmentModel {
  String notes, condition, recommendations, cgInstr, dataDesc;
  int id, patientID;

  AssessmentModel(
    this.id,
    this.notes,
    this.condition,
    this.recommendations,
    this.cgInstr,
    this.dataDesc,
    this.patientID,
  );

  AssessmentModel.fromJson(parsedJson)
      : id = parsedJson["id"],
        notes = parsedJson["notes"],
        condition = parsedJson["condition"],
        recommendations = parsedJson["recommendations"],
        cgInstr = parsedJson["cg_instr"],
        dataDesc = parsedJson["data_desc"],
        patientID = parsedJson["patient"]["id"];

  @override
  String toString() {
    return '''{
        "notes": "$notes",
        "condition": "$condition",
        "recommendations": "$recommendations",
        "cg_instr": "$cgInstr",
        "data_desc": "$dataDesc",
        "patient_id": $patientID
      }''';
  }
}
