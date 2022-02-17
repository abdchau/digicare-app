import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../models/user_model.dart';
import '../resources/rest_api.dart';

class UserBloc {
  final _userFetch = BehaviorSubject<int>();
  late Stream<Future<UserModel>> _user;
  final _api = RestAPI();
  int _count = 0;

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
        print("Here $_count");
        final _user = _api.loginAndFetchUser(_count);
        sink.add(_user);
        _count++;
      },
    );
  }
}
