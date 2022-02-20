import 'dart:convert' show json;

import 'address_model.dart';

class UserModel {
  String firstName, lastName, email, password, phoneNo, cnic;
  // DateTime dob;
  AddressModel address;
  int id, age;

  UserModel(
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phoneNo,
    this.cnic,
    // this.dob,
    this.address,
    this.id,
    this.age,
  );

  UserModel.fromJson(Map<String, dynamic> parsedJson)
      : firstName = parsedJson['firstName'] ?? "NO NAME FROM API",
        lastName = parsedJson['lastName'] ?? "NO NAME FROM API",
        email = parsedJson['email'] ?? "NO EMAIL FROM API",
        password = parsedJson['password'] ?? "NO PASSWORD FROM API",
        phoneNo = parsedJson['phone_no'] ?? "NO PHONENO FROM API",
        cnic = parsedJson['cnic'] ?? "NO CNIC FROM API",
        address = AddressModel.fromJson(parsedJson['address']),
        id = parsedJson['id'] ?? -999,
        age = parsedJson['age'] ?? -9999;

  @override
  String toString() {
    return "$id, $firstName, $lastName, $email, $password, $phoneNo, $cnic, $age, $address";
  }
}
