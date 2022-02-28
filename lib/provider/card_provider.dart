import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../url.dart';

class CardProvider with ChangeNotifier {
  Map<String, dynamic> _cardList = {};

  Map<String, dynamic> get cardList => _cardList;

  String _errorMessage = "";
  bool _error = false;
  String get errorMessage => _errorMessage;
  bool get error => _error;

  Future<void> getCardInfo() async {
    try {
      bool _error = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final _stdId = prefs.getInt('stdId') ?? 0;
      print('_stdId $_stdId');
      var url = "$National/api/CardInfo/id?stdId=$_stdId";
      // var url = "$National/api/CardInfo/id?stdId=$_stdId";

      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      final response = await ioClient.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      if (response.statusCode == 200) {
        _cardList = jsonDecode(response.body);
        print(_cardList);
      } else {
        _error = true;
      }
    } catch (error) {
      print(error);
      _error = true;
    }
    notifyListeners();
  }

  Future<void> getCurriculum() async {
    try {
      bool _error = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final facultyNo = prefs.getInt('facultyNo') ?? 0;
      print('facultyNo $facultyNo');
      var url = "$National/api/AttendanceSubject?facultyId=$facultyNo";

      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      final response = await ioClient.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      if (response.statusCode == 200) {
        _cardList = jsonDecode(response.body);
        print(_cardList);
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
