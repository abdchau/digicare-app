class UserModel {
  String firstName, lastName, email, password, phoneNo, cnic;
  int age;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNo,
    required this.cnic,
    required this.age,
  });

  UserModel.fromJson(Map<String, dynamic> parsedJson)
      : firstName = parsedJson['firstName'] ?? "NO NAME FROM API",
        lastName = parsedJson['lastName'] ?? "NO NAME FROM API",
        email = parsedJson['email'] ?? "NO EMAIL FROM API",
        password = parsedJson['password'] ?? "NO PASSWORD FROM API",
        phoneNo = parsedJson['phone_no'] ?? "NO PHONENO FROM API",
        cnic = parsedJson['cnic'] ?? "NO CNIC FROM API",
        age = parsedJson['age'] ?? -9999;

  @override
  String toString() {
    return "$firstName, $lastName, $email, $password, $phoneNo, $cnic, $age";
  }
}
