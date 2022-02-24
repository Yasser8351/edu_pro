import 'package:flutter/cupertino.dart';

class RegistrationModel {
  int? installmentId;
  bool? isImmediate;
  String? dateFrom;
  String? dateTo;
  int? percentage;
  String? installmentName;

  RegistrationModel({
    @required this.installmentId,
    @required this.isImmediate,
    @required this.dateFrom,
    @required this.dateTo,
    @required this.percentage,
    @required this.installmentName,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> jsonData) {
    return RegistrationModel(
      installmentId: jsonData['installmentId'] ?? 0,
      isImmediate: jsonData['isImmediate'] ?? false,
      dateFrom: jsonData['dateFrom'] ?? '',
      dateTo: jsonData['dateTo'] ?? '',
      percentage: jsonData['percentage'] ?? 0,
      installmentName: jsonData['installmentName'] ?? '',
    );
  }
}

class RegistrationList {
  final List<dynamic> listRegistration;
  RegistrationList({required this.listRegistration});
  factory RegistrationList.fromJson(Map<String, dynamic> jsonData) {
    return RegistrationList(
      listRegistration: jsonData['registration'],
    );
  }
}

/*
"registration": [
    {
      "installmentId": 11041,
      "isImmediate": false,
      "dateFrom": "2021-01-10T00:00:00",
      "dateTo": "2021-01-15T00:00:00",
      "percentage": 50,
      "installmentPolicyNo": 11013,
      "installmentName": "First"
    },
*/