import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';

class AnnouncementsProvider with ChangeNotifier {
  Map<String, dynamic> _anouncementsList = {};

  Map<String, dynamic> get anouncementsList => _anouncementsList;

  String _errorMessage = "";
  bool _error = false;
  String get errorMessage => _errorMessage;
  bool get error => _error;

  Future<void> getAnnouncements() async {
    try {
      bool _error = false;
      var url = "https://192.168.1.188:3000/api/Announcement/id?stdId=67121";

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
