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

class RegistrationFeesModel {
  double courseFeesSDG;
  double registerationFeesSDG;
  double courseFeesUSD;
  double registerationFeesUSD;
  double admissionFeesSDG;
  double admissionFeesUSD;
  double transferFeesSDG;
  double transferFeesUSD;
  double foreignersCourseFeesUSD;
  double trainingFees;
  double bridgingFeesSDG;
  double bridgingFeesUSD;
  bool registrationStatus;
  int semesterNo;
  int academicYearNo;
  int facultyInformationId;

  RegistrationFeesModel({
    required this.courseFeesSDG,
    required this.registerationFeesSDG,
    required this.courseFeesUSD,
    required this.registerationFeesUSD,
    required this.admissionFeesSDG,
    required this.admissionFeesUSD,
    required this.transferFeesSDG,
    required this.transferFeesUSD,
    required this.foreignersCourseFeesUSD,
    required this.trainingFees,
    required this.bridgingFeesSDG,
    required this.bridgingFeesUSD,
    required this.registrationStatus,
    required this.semesterNo,
    required this.academicYearNo,
    required this.facultyInformationId,
  });

  factory RegistrationFeesModel.fromJson(Map<String, dynamic> jsonData) {
    return RegistrationFeesModel(
      courseFeesSDG: jsonData['courseFeesSDG'] ?? 00.00,
      registerationFeesSDG: jsonData['registerationFeesSDG'] ?? 00.00,
      courseFeesUSD: jsonData['courseFeesUSD'] ?? 00.00,
      registerationFeesUSD: jsonData['registerationFeesUSD'] ?? 00.00,
      admissionFeesSDG: jsonData['admissionFeesSDG'] ?? 00.00,
      admissionFeesUSD: jsonData['admissionFeesUSD'] ?? 00.00,
      transferFeesSDG: jsonData['transferFeesSDG'] ?? 00.00,
      transferFeesUSD: jsonData['transferFeesUSD'] ?? 00.00,
      foreignersCourseFeesUSD: jsonData['foreignersCourseFeesUSD'] ?? 00.00,
      trainingFees: jsonData['trainingFees'] ?? 00.00,
      bridgingFeesSDG: jsonData['bridgingFeesSDG'] ?? 00.00,
      bridgingFeesUSD: jsonData['bridgingFeesUSD'] ?? 00.00,
      semesterNo: jsonData['semesterNo'] ?? 0,
      academicYearNo: jsonData['academicYearNo'] ?? 0,
      facultyInformationId: jsonData['facultyInformationId'] ?? 0,
      registrationStatus: jsonData['registrationStatus'] ?? false,
    );
  }
}

// class RegistrationFeesList {
//   final List<dynamic> listFeeRestriction;
//   RegistrationFeesList({required this.listFeeRestriction});
//   factory RegistrationFeesList.fromJson(Map<String, dynamic> jsonData) {
//     return RegistrationFeesList(
//       listFeeRestriction: jsonData['registration'],
//     );
//   }
// }

/*
        "facultyInformationId": 14122,
        "facultyNo": 1107,
        "facultyBatchId": 1616,
        "semesterNo": 1656,
        "academicYearNo": 141,
        "courseFeesSDG": 25000.00,
        "registerationFeesSDG": 1000.00,
        "courseFeesUSD": 3000.00,
        "registerationFeesUSD": 100.00,
        "admissionFeesSDG": 1000.00,


        "admissionFeesUSD": 300.00,
        "transferFeesSDG": 1000.00,
        "transferFeesUSD": 100.00,
        "facultyProgramNo": 10078,
        "facultyProgramSpecializationNo": 12134,
        "registerationDate": null,
        "foreignersCourseFeesUSD": 3000.00,
        "trainingFees": 10000.00,
        "registrationStatus": true,
        "bridgingFeesSDG": 100000.00,
        "bridgingFeesUSD": 10000.00,
        "otherFeesSDG": 3000.00,
        "otherFeesUSD": 300.00
*/