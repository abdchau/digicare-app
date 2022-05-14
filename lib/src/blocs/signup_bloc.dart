import 'package:rxdart/rxdart.dart';

import '../mixins/validators.dart';

class SignupBloc with Validator {
  final _firstName = BehaviorSubject<String>();
  final _lastName = BehaviorSubject<String>();
  // final _active = BehaviorSubject<boolean>();
  final _username = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _phoneNo = BehaviorSubject<String>();

  Function(String) get changeFirstName => _firstName.sink.add;
  Function(String) get changeLastName => _lastName.sink.add;
  // Function(boolean) get change_active => _active.sink.add;
  Function(String) get changeUsername => _username.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changePhoneNo => _phoneNo.sink.add;

  Stream<String> get firstNameStream =>
      _firstName.stream.transform(validateText);
  Stream<String> get lastNameStream => _lastName.stream.transform(validateText);
  Stream<String> get usernameStream => _username.stream.transform(validateText);
  Stream<String> get phoneNoStream => _phoneNo.stream.transform(validateText);

  Stream<String> get emailStream => _email.stream.transform(validateEmail);
  Stream<String> get passwordStream =>
      _password.stream.transform(validatePassword);

  CombineLatestStream<dynamic, bool> get submitValid =>
      CombineLatestStream.combine6(
        firstNameStream,
        lastNameStream,
        usernameStream,
        phoneNoStream,
        emailStream,
        passwordStream,
        (f, l, u, ph, e, p) => true,
      );

  void submit() {
    //  _firstName.value;
    //  _lastName.value;
    //  _username.value;
    //  _phoneNo.value;
    //  _email.value;
    //  _password.value;
    print('Signed up yay');
  }
}

/*
String firstName
String lastName
boolean active
String username
String email
String password
String phone_no
Date dob
Gender gender
String cnic
int age
String emergencey_contact
User cg_user
String cg_relationship
Role> roles
Address address
*/