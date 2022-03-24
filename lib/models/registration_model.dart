import 'package:flutter/cupertino.dart';

class RegistrationModel {
  int? installmentId;
  int? percentage;
  int? installmentPolicyNo;
  bool? isImmediate;
  String? dateFrom;
  String? dateTo;
  String? installmentName;

  RegistrationModel({
    @required this.installmentId,
    @required this.percentage,
    @required this.installmentPolicyNo,
    @required this.isImmediate,
    @required this.dateFrom,
    @required this.dateTo,
    @required this.installmentName,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> jsonData) {
    return RegistrationModel(
      installmentId: jsonData['installmentId'] ?? 0,
      percentage: jsonData['percentage'] ?? 0,
      installmentPolicyNo: jsonData['installmentPolicyNo'] ?? 0,
      dateFrom: jsonData['dateFrom'] ?? "",
      dateTo: jsonData['dateTo'] ?? "",
      installmentName: jsonData['installmentName'] ?? "",
      isImmediate: jsonData['isImmediate'] ?? false,
    );
  }
}

class RegistrationList {
  final List<dynamic> listRestriction;
  RegistrationList({required this.listRestriction});
  factory RegistrationList.fromJson(Map<String, dynamic> jsonData) {
    return RegistrationList(
      listRestriction: jsonData['registration'],
    );
  }
}
/*
            "installmentId": 11043,
            "isImmediate": false,
            "dateFrom": "2021-01-10T00:00:00",
            "dateTo": "2021-01-15T00:00:00",
            "percentage": 50,
            "installmentPolicyNo": 11014,
            "installmentName": "First"
*/