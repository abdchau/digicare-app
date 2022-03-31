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
  }

  // getters to streams
  Stream<Future<UserModel>> get userStream => _user;
  Stream<Future<List<UserModel>?>> get patientsStream => _patients;

  // getters to sinks
  void Function(int) get fetchUser => _userFetch.sink.add;
  void Function(int) get fetchPatients => _patientsFetch.sink.add;

  StreamTransformer<int, Future<UserModel>> _userTransformer() {
    return StreamTransformer<int, Future<UserModel>>.fromHandlers(
      handleData: (int userID, sink) {
        print("IN USERTRANSFORMER");
        final _user = _api.fetchUser(jwt, _email);
        sink.add(_user);
      },
    );
  }

  StreamTransformer<int, Future<List<UserModel>?>> _patientsTransformer() {
    return StreamTransformer<int, Future<List<UserModel>?>>.fromHandlers(
      handleData: (int userID, sink) {
        print("IN USERTRANSFORMER");
        final _patients1 = _api.fetchDoctorsPatients(jwt, id);
        sink.add(_patients1);
      },
    );
  }
}
