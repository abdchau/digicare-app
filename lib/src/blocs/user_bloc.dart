import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../models/user_model.dart';
import '../resources/rest_api.dart';

class UserBloc {
  final _userFetch = BehaviorSubject<int>();
  late Stream<Future<UserModel>> _user;
  final _api = RestAPI();
  late String jwt, _email;
  late int _id;

  set setJWT(String jwt) {
    this.jwt = jwt;
  }

  set setEmail(String email) {
    _email = email;
  }

  set setID(int id) {
    _id = id;
  }

  UserBloc() {
    _user = _userFetch.stream.transform(_userTransformer());
  }

  // getters to streams
  Stream<Future<UserModel>> get userStream => _user;

  // getters to sinks
  void Function(int) get fetchUser => _userFetch.sink.add;

  StreamTransformer<int, Future<UserModel>> _userTransformer() {
    return StreamTransformer<int, Future<UserModel>>.fromHandlers(
      handleData: (int userID, sink) {
        print("IN USERTRANSFORMER");
        final _user = _api.fetchUser(jwt, _email);
        sink.add(_user);
      },
    );
  }
}
