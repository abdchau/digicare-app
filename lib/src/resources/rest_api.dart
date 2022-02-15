import 'package:http/http.dart';
import 'package:http/testing.dart';
import '../models/user_model.dart';

class RestAPI {
  final client = Client();

  UserModel? loginAndFetchUser(String email, String password) {
    if (email.compareTo("sajeel@coolboi.com") == 0 &&
        password.compareTo("dingdong") == 0) {
      return UserModel(
        firstName: "Sajeel",
        lastName: "Hassan",
        email: "sajeel@coolboi.com",
        password: "dingdong",
        phoneNo: "12345678",
        cnic: "611014582215",
        age: 22,
      );
    } else {
      return null;
    }
  }
}
