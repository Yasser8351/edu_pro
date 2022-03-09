import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../url.dart';

class AnnouncementsProvider with ChangeNotifier {
  Map<String, dynamic> _anouncementsList = {};

  Map<String, dynamic> get anouncementsList => _anouncementsList;

  String _errorMessage = "";
  bool _error = false;
  String get errorMessage => _errorMessage;
  bool get error => _error;

  Future<void> getAnnouncements() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final stdId = prefs.getInt('stdId') ?? 0;
    try {
      bool _error = false;
      var url = "${AppSettings.URL}/api/Announcement/id?stdId=$stdId";

      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      final response = await ioClient.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      if (response.statusCode == 200) {
        _anouncementsList = jsonDecode(response.body);
        print(_anouncementsList);
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
