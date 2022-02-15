import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:digicare/src/models/user_model.dart';

class DashboardBloc {
  final _userFetch = StreamController<int>();
  final _userOutput = StreamController<Future<UserModel>>();

  // getters to streams
  Stream<Future<UserModel>> get userStream => _userOutput.stream;

  // getters to sinks
  Function(int) get fetchUser => _userFetch.sink.add;
}
