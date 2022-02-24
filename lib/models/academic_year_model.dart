import 'package:flutter/cupertino.dart';

class AcademicYearModel {
  int? yearId;
  String? yearName;

  AcademicYearModel({
    @required this.yearId,
    @required this.yearName,
  });

  factory AcademicYearModel.fromJson(Map<String, dynamic> jsonData) {
    return AcademicYearModel(
      yearId: jsonData['yearId'],
      yearName: jsonData['yearName'],
    );
  }
}

class AcademicYearList {
  final List<dynamic> listAcademicYear;
  AcademicYearList({required this.listAcademicYear});
  factory AcademicYearList.fromJson(Map<String, dynamic> jsonData) {
    return AcademicYearList(
      listAcademicYear: jsonData['academicList'],
    );
  }
}
