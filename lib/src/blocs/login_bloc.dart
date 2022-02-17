import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import '../mixins/validators.dart';

class LoginBloc with Validator {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  Stream<String> get emailStream => _email.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _password.stream.transform(validatePassword);

  CombineLatestStream<dynamic, bool> get submitValid =>
      CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

  void submit(BuildContext context) {
    final validEmail = _email.value;
    final validPassword = _password.value;
    print("Off to the API with $validEmail, $validPassword");
    Navigator.pushNamed(context, "/dashboard");
  }
}
