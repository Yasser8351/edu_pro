import 'package:flutter/cupertino.dart';

class CurriculumModel {
  int? curriculumId;
  String? curriculumName;
  String? dateFrom;

  CurriculumModel({
    @required this.curriculumId,
    @required this.curriculumName,
    @required this.dateFrom,
  });

  factory CurriculumModel.fromJson(Map<String, dynamic> jsonData) {
    return CurriculumModel(
      curriculumId: jsonData['curriculumId'],
      curriculumName: jsonData['curriculumName'],
      dateFrom: jsonData['dateFrom'],
    );
  }
}

class CurriculumList {
  final List<dynamic> listAcademicYear;
  CurriculumList({required this.listAcademicYear});
  factory CurriculumList.fromJson(Map<String, dynamic> jsonData) {
    return CurriculumList(
      listAcademicYear: jsonData['curriculums'],
    );
  }
}
//CurriculumCourseModel

/*
{
  "curriculums": [
    {
      "curriculumId": 3735,
      "curriculumName": "Communication Skills",
      "facultyNo": 1107,
      "dateFrom": "2022-01-10T00:00:00",
      "dateTo": null,
      "isActive": true
    }
  ]
*/