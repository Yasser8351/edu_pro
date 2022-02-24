import 'package:flutter/cupertino.dart';

class CurriculumCourseModel {
  String? code;
  String? unitName;
  String? knowledgeUnitName;
  String? semesterName;
  String? courseOutcome;
  String? assesmentMethod;
  String? reference;
  double? totalCreditHours;
  bool isContinuous;
  bool isElective;
  bool hasPrize;
  bool linkedToSubject;
  bool countInGpa;

  CurriculumCourseModel({
    @required this.code,
    @required this.unitName,
    @required this.knowledgeUnitName,
    @required this.semesterName,
    @required this.totalCreditHours,
    @required this.courseOutcome,
    @required this.assesmentMethod,
    required this.isContinuous,
    required this.isElective,
    required this.hasPrize,
    required this.countInGpa,
    required this.linkedToSubject,
    required this.reference,
  });

  factory CurriculumCourseModel.fromJson(Map<String, dynamic> jsonData) {
    return CurriculumCourseModel(
      code: jsonData['code'] ?? '- - - -',
      unitName: jsonData['unitName'] ?? '- - - -',
      reference: jsonData['reference'] ?? '- - - -',
      knowledgeUnitName: jsonData['knowledgeUnitName'] ?? '- - - -',
      totalCreditHours: jsonData['totalCreditHours'] ?? 0.0,
      semesterName: jsonData['semesterName'] ?? '- - - -',
      courseOutcome: jsonData['courseOutcome'] ?? '- - - -',
      assesmentMethod: jsonData['assesmentMethod'] ?? '- - - -',
      isContinuous: jsonData['isContinuous'] ?? false,
      isElective: jsonData['isElective'] ?? false,
      hasPrize: jsonData['hasPrize'] ?? false,
      countInGpa: jsonData['countInGpa'] ?? false,
      linkedToSubject: jsonData['linkedToSubject'] ?? false,
    );
  }
}

class CurriculumCourseList {
  final List<dynamic> listCurriculumCourseList;
  CurriculumCourseList({required this.listCurriculumCourseList});
  factory CurriculumCourseList.fromJson(Map<String, dynamic> jsonData) {
    return CurriculumCourseList(
      listCurriculumCourseList: jsonData['course'],
    );
  }
}
//CurriculumCourseModel

/*
      "courseId": 6562,
      "curriculumNo": 3735,
      "knowledgeUnitNo": 6211,
      "facultyUnitNo": 3028,
      "facultyDepartmentNo": 8080,
      "totalCreditHours": 3,
      "assesmentMethod": "Assignments ",
      "courseOutcome": "",
      "reference": "",
      "isContinuous": null,
      "isElective": null,
      "linkedToSubject": null,
      "countInGpa": null,
      "hasPrize": null,
      "knowledgeAreaNo": 3080,
      "knowledgeUnitName": "Test",
      "code": "Te",
      "semesterName": "semester 1 ",
      "departmentName": "HASH",
      "unitName": "HASH Unit",
   
*/