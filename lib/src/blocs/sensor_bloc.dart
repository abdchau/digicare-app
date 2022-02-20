import 'package:digicare/src/models/reading_model.dart';
import 'package:digicare/src/models/sensor_model.dart';

import '../resources/rest_api.dart';

class SensorBloc {
  late final String _sensor;
  final _api = RestAPI();

  SensorBloc(String sensor) : _sensor = sensor;

  Future<List<SensorModel>> fetchAllSensors(String jwt) async {
    return _api.fetchAllSensors(jwt);
  }

  Future<List<ReadingModel>> fetchSensorReadings(
      String jwt, int patientID, int sensorID) {
    return _api.fetchSensorReadings(jwt, patientID, sensorID);
  }
}
