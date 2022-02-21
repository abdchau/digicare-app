import 'package:flutter/rendering.dart';
import 'dart:async' show StreamTransformer;
import 'package:rxdart/rxdart.dart';

import '../models/reading_model.dart';
import '../models/sensor_model.dart';
import '../resources/rest_api.dart';

class SensorBloc {
  final _sensorsFetch = BehaviorSubject<String>();
  late Stream<Future<List<SensorModel>>> _sensor;
  final _api = RestAPI();

  SensorBloc() {
    _sensor = _sensorsFetch.stream.transform(_sensorTransformer());
  }

  // getters to streams
  Stream<Future<List<SensorModel>>> get sensorsStream => _sensor;

  // getters to sinks
  void Function(String) get fetchSensors => _sensorsFetch.sink.add;

  StreamTransformer<String, Future<List<SensorModel>>> _sensorTransformer() {
    return StreamTransformer<String, Future<List<SensorModel>>>.fromHandlers(
      handleData: (String jwt, sink) {
        print("IN SENSORTRANSFORMER");
        final sensors = _api.fetchAllSensors(jwt);
        sink.add(sensors);
      },
    );
  }

  Future<List<ReadingModel>> fetchSensorReadings(
      String jwt, int patientID, int sensorID) {
    return _api.fetchSensorReadings(jwt, patientID, sensorID);
  }
}
