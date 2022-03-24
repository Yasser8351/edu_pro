import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../url.dart';

class RegistrationProvider with ChangeNotifier {
  var _registrationList = {};
  // Map<String, dynamic> registrationList = {};

  get cardList => _registrationList;

  String _errorMessage = "";
  bool _error = false;
  String get errorMessage => _errorMessage;
  bool get error => _error;

  Future<void> getRegistration() async {
    print("registrationList");

    try {
      bool _error = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final _stdId = prefs.getInt('stdId') ?? 0;
      var url = "https://192.168.1.188:3000/api/Test?studentNo=671212";
      // var url = "${AppSettings.URL}/api/CardInfo/id?stdId=$_stdId";

      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      final response = await ioClient.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      if (response.statusCode == 200) {
        _registrationList = jsonDecode(response.body);
        print("_registrationList $_registrationList");
      } else {
        _error = true;
        print("error");
      }
    } catch (error) {
      _error = true;
      print("error $error");
    }
    notifyListeners();
  }
}
