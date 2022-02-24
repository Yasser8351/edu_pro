import 'package:flutter/cupertino.dart';

class SubjectAttendanceModel {
  final int? courseId;
  final String? subjectName;

  SubjectAttendanceModel({
    @required this.subjectName,
    @required this.courseId,
  });

  factory SubjectAttendanceModel.fromJson(Map<String, dynamic> jsonData) {
    return SubjectAttendanceModel(
      subjectName: jsonData['subjectName'],
      courseId: jsonData['courseId'],
    );
  }
}

class SubjectAttendanceList {
  final List<dynamic> listSubjectAttendance;
  SubjectAttendanceList({required this.listSubjectAttendance});
  factory SubjectAttendanceList.fromJson(Map<String, dynamic> jsonData) {
    return SubjectAttendanceList(
      listSubjectAttendance: jsonData['subject'],
    );
  }
}
