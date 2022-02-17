import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import '../models/user_model.dart';

class RestAPI {
  final client = Client();

  Future<UserModel> loginAndFetchUser(int userID) async {
    // if (email.compareTo("sajeel@coolboi.com") == 0 &&
    //     password.compareTo("dingdong") == 0) {
    if (userID == 1) {
      return Future.delayed(
        const Duration(seconds: 3),
        () => UserModel(
          firstName: "Sajeel",
          lastName: "Hassan",
          email: "sajeel@coolboi.com",
          password: "dingdong",
          phoneNo: "12345678",
          cnic: "611014582215",
          age: 22,
        ),
      );
    } else {
      return Future.delayed(
        const Duration(seconds: 3),
        () => UserModel(
          firstName: "Hamza",
          lastName: "Hassan",
          email: "sajeel@coolboi.com",
          password: "dingdong",
          phoneNo: "12345678",
          cnic: "611014582215",
          age: 22,
        ),
      );
    }
  }
}
