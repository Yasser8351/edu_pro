import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';

class GradeSystemProvider with ChangeNotifier {
  Map<String, dynamic> _gradeSystemNoList = {};

  Map<String, dynamic> get gradeSystemNoList => _gradeSystemNoList;

  Map<String, dynamic> _gradeSystemList = {};

  Map<String, dynamic> get gradeSystemList => _gradeSystemList;

  String _errorMessage = "";
  bool _error = false;
  String get errorMessage => _errorMessage;
  bool get error => _error;

  //1. get GradeSystemNo By STDId
  //https://192.168.1.188:3000/api/GradeSystem/id?stdId=151
  //2. get All GradeSystem By GradeSystemNo
  //https://192.168.1.188:3000/api/GradeSystemMark/id?grade=20

  Future<void> getGradeSystemNo() async {
    try {
      bool _error = false;
      var url = "https://192.168.1.188:3000/api/GradeSystem/id?stdId=150";

      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      final response = await ioClient.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      if (response.statusCode == 200) {
        _gradeSystemNoList = jsonDecode(response.body);
        print(_gradeSystemNoList);
      } else {
        _error = true;
      }
    } catch (error) {
      print(error);
      _error = true;
    }
    notifyListeners();
  }

  Future<void> getGradeDetails(int grade) async {
    try {
      bool _error = false;
      var url =
          "https://192.168.1.188:3000/api/GradeSystemMark/id?grade=$grade";

      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      final response = await ioClient.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      if (response.statusCode == 200) {
        _gradeSystemList = jsonDecode(response.body);
        print(_gradeSystemList);
      } else {
        _error = true;
      }
    } catch (error) {
      print(error);
      _error = true;
    }
    notifyListeners();
  }
}
