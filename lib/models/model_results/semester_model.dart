import 'package:flutter/cupertino.dart';

class SemesterModel {
  int? semesterId;
  String? semesterName;

  SemesterModel({
    @required this.semesterId,
    @required this.semesterName,
  });

  factory SemesterModel.fromJson(Map<String, dynamic> jsonData) {
    return SemesterModel(
      semesterId: jsonData['facultySemesterId'],
      semesterName: jsonData['semesterName'],
    );
  }
}

class SemestersList {
  final List<dynamic> listSemester;
  SemestersList({required this.listSemester});
  factory SemestersList.fromJson(Map<String, dynamic> jsonData) {
    return SemestersList(
      listSemester: jsonData['semesters'],
    );
  }
}
