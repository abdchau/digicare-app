import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../models/user_model.dart';
import '../resources/rest_api.dart';

class UserBloc {
  final _userFetch = BehaviorSubject<int>();
  late Stream<Future<UserModel>> _user;
  final _api = RestAPI();
  late String jwt, _email;
  late int id;
  late int patientID;

  final _patientsFetch = BehaviorSubject<int>();
  late Stream<Future<List<UserModel>?>> _patients;

  final _doctorsFetch = BehaviorSubject<int>();
  late Stream<Future<List<UserModel>?>> _doctors;

  final _allDoctorsFetch = BehaviorSubject<int>();
  late Stream<Future<List<UserModel>?>> _allDoctors;

  set setJWT(String jwt) {
    this.jwt = jwt;
  }

  set setEmail(String email) {
    _email = email;
  }

  set setID(int id) {
    this.id = id;
  }

  set setPatientID(int id) {
    patientID = id;
  }

  UserBloc() {
    print("USERBLOC INIT");
    _user = _userFetch.stream.transform(_userTransformer());
    _patients = _patientsFetch.stream.transform(_patientsTransformer());
    _doctors = _doctorsFetch.stream.transform(_doctorsTransformer());
    _allDoctors = _allDoctorsFetch.stream.transform(_allDoctorsTransformer());
  }

  // getters to streams
  Stream<Future<UserModel>> get userStream => _user;
  Stream<Future<List<UserModel>?>> get patientsStream => _patients;
  Stream<Future<List<UserModel>?>> get doctorsStream => _doctors;
  Stream<Future<List<UserModel>?>> get allDoctorsStream => _allDoctors;

  // getters to sinks
  void Function(int) get fetchUser => _userFetch.sink.add;
  void Function(int) get fetchPatients => _patientsFetch.sink.add;
  void Function(int) get fetchDoctors => _doctorsFetch.sink.add;
  void Function(int) get fetchAllDoctors => _allDoctorsFetch.sink.add;

  StreamTransformer<int, Future<UserModel>> _userTransformer() {
    return StreamTransformer<int, Future<UserModel>>.fromHandlers(
      handleData: (int userID, sink) {
        print("IN USERTRANSFORMER");
        final _userReturned = _api.fetchUser(jwt, _email);
        sink.add(_userReturned);
      },
    );
  }

  StreamTransformer<int, Future<List<UserModel>?>> _patientsTransformer() {
    return StreamTransformer<int, Future<List<UserModel>?>>.fromHandlers(
      handleData: (int userID, sink) {
        print("IN USERTRANSFORMER");
        final _patientsReturned = _api.fetchDoctorsPatients(jwt, id);
        sink.add(_patientsReturned);
      },
    );
  }

  StreamTransformer<int, Future<List<UserModel>?>> _doctorsTransformer() {
    return StreamTransformer<int, Future<List<UserModel>?>>.fromHandlers(
      handleData: (int userID, sink) {
        print("IN PATIENTS DOCTOR TRANSFORMER");
        final _doctorsReturned = _api.fetchPatientsDoctors(jwt, id);
        if (_doctorsReturned == null) {
          sink.addError("No doctors found");
        } else {
          sink.add(_doctorsReturned);
        }
      },
    );
  }

  StreamTransformer<int, Future<List<UserModel>?>> _allDoctorsTransformer() {
    return StreamTransformer<int, Future<List<UserModel>?>>.fromHandlers(
      handleData: (int userID, sink) {
        print("IN ALL DOCTORS TRANSFORMER");
        final _doctorsReturned = _api.fetchAllOfRole(jwt, 'ROLE_DOCTOR');
        if (_doctorsReturned == null) {
          sink.addError("No doctors found");
        } else {
          sink.add(_doctorsReturned);
        }
      },
    );
  }

  void addDoctorPermission(int doctorID) async {
    await _api.addDoctorPermission(jwt, patientID, doctorID);
    print('Added $patientID $doctorID');
  }

  void revokeDoctorPermission(int doctorID) async {
    await _api.revokeDoctorPermission(jwt, patientID, doctorID);
    print("Revoked $patientID $doctorID");
  }
}
