import 'dart:convert' show json;
import 'package:http/http.dart';
// import 'package:http/testing.dart';

import '../models/user_model.dart';

class RestAPI {
  final Client client = Client();
  final String _hostAddress = "http://10.0.2.2:8080";

  Future<String?> authenticate(String email, String password) async {
    Response response = await client.post(
      Uri.parse("$_hostAddress/authenticate"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: '{"email": "$email","password": "$password"}',
    );
    print(response.statusCode);
    if (response.statusCode != 200) {
      return null;
    }

    return json.decode(response.body)['token'];
  }

  Future<UserModel> fetchUser(String jwt, String email) async {
    // if (email.compareTo("sajeel@coolboi.com") == 0 &&
    //     password.compareTo("dingdong") == 0) {

    Response response = await client.get(
      Uri.parse("$_hostAddress/users/email/$email"),
      headers: <String, String>{
        "Authorization": "Bearer $jwt",
      },
    );
    print("${response.body} HEREEE");
    final user = UserModel.fromJson(json.decode(response.body));
    print("hi");
    print(user);
    return user;
    // int userID = 1;
    // if (userID == 1) {
    //   return Future.delayed(
    //     const Duration(seconds: 3),
    //     () => UserModel(
    //       firstName: "Sajeel",
    //       lastName: "Hassan",
    //       email: "sajeel@coolboi.com",
    //       password: "dingdong",
    //       phoneNo: "12345678",
    //       cnic: "611014582215",
    //       age: 22,
    //     ),
    //   );
    // } else {
    //   return Future.delayed(
    //     const Duration(seconds: 3),
    //     () => UserModel(
    //       firstName: "Hamza",
    //       lastName: "Hassan",
    //       email: "sajeel@coolboi.com",
    //       password: "dingdong",
    //       phoneNo: "12345678",
    //       cnic: "611014582215",
    //       age: 22,
    //     ),
    //   );
    // }
  }
}
