import 'dart:convert' show json;
import 'package:digicare/src/models/reading_model.dart';
import 'package:digicare/src/models/sensor_model.dart';
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
    await Future.delayed(const Duration(seconds: 2));
    Response response = await client.get(
      Uri.parse("$_hostAddress/users/email/$email"),
      headers: <String, String>{
        "Authorization": "Bearer $jwt",
      },
    );
    print("${response.body} USER API");
    final user = UserModel.fromJson(json.decode(response.body));
    print(user);
    return user;
  }

  Future<List<SensorModel>> fetchAllSensors(String jwt) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    Response response = await client.get(
      Uri.parse("$_hostAddress/sensors"),
      headers: <String, String>{
        "Authorization": "Bearer $jwt",
      },
    );
    print(response.body);
    final List list = json.decode(response.body)['_embedded']['sensorList'];
    final ret = SensorModel.list(list);
    print("$ret SENSOR API");
    return ret;
  }

  Future<List<ReadingModel>?> fetchSensorReadings(
      String jwt, int patientID, int sensorID) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Response response = await client.get(
      Uri.parse("$_hostAddress/readings/patient/$patientID/$sensorID"),
      headers: <String, String>{
        "Authorization": "Bearer $jwt",
      },
    );
    print(response.body);
    final res = json.decode(response.body)['_embedded'];
    if (res.containsKey('sensorPatientDataList')) {
      final ret = ReadingModel.list(res['sensorPatientDataList']);
      print("$ret SENSOR READING API");
      return ret;
    } else {
      return null;
    }
  }

  Future<List<UserModel>?> fetchDoctorsPatients(
      String jwt, int doctorID) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Response response = await client.get(
      Uri.parse("$_hostAddress/permission/doctor/$doctorID"),
      headers: <String, String>{
        "Authorization": "Bearer $jwt",
      },
    );
    print(response.body);

    final res = json.decode(response.body)['_embedded'];
    if (res.containsKey('patientDoctorList')) {
      List<UserModel> patients = [];
      for (var patient in res['patientDoctorList']) {
        patients.add(UserModel.fromJson(patient['patient']));
      }

      print("$patients DOCTOR'S PATIENTS API");

      return patients;
    } else {
      return null;
    }
  }

  Future<List<UserModel>?> fetchPatientsDoctors(
      String jwt, int patientID) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Response response = await client.get(
      Uri.parse("$_hostAddress/permission/patient/$patientID"),
      headers: <String, String>{
        "Authorization": "Bearer $jwt",
      },
    );
    print(response.body);

    final res = json.decode(response.body)['_embedded'];
    // print("$res AAAAAAAAAAAAAAAAAAA");
    if (res.containsKey('patientDoctorList')) {
      List<UserModel> doctors = [];
      for (var patient in res['patientDoctorList']) {
        doctors.add(UserModel.fromJson(patient['doctor']));
      }

      print("$doctors PATIENT'S DOCTORS API");

      return doctors;
    } else {
      print('HEREEEE');
      return null;
    }
  }

  Future<List<UserModel>?> fetchAllOfRole(String jwt, String role) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    Response response = await client.get(
      Uri.parse("$_hostAddress/users/role/$role"),
      headers: <String, String>{
        "Authorization": "Bearer $jwt",
      },
    );

    print(response.body);

    final res = json.decode(response.body)['_embedded'];
    if (res.containsKey('userList')) {
      List<UserModel> doctors = [];
      for (var doctor in res['userList']) {
        doctors.add(UserModel.fromJson(doctor));
      }
      return doctors;
    }
    return null;
  }

  Future<void> revokeDoctorPermission(
      String jwt, int patientID, int doctorID) async {
    Response response = await client.delete(
      Uri.parse("$_hostAddress/permission/$patientID/$doctorID"),
      headers: <String, String>{
        "Authorization": "Bearer $jwt",
      },
    );
    print(response.body);
    if (response.statusCode != 200) {
      throw (response.statusCode);
    }
  }
}
