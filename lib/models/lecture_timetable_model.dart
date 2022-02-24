import 'package:flutter/cupertino.dart';

class LectureTimetableModel {
  String? title;
  String? dayName;
  String? startTime;
  String? endTime;
  String? weekName;
  String? hallName;

  LectureTimetableModel({
    @required this.dayName,
    @required this.endTime,
    @required this.startTime,
    @required this.weekName,
    @required this.title,
    @required this.hallName,
  });

  factory LectureTimetableModel.fromJson(Map<String, dynamic> jsonData) {
    return LectureTimetableModel(
      dayName: jsonData['dayName'],
      endTime: jsonData['endTime'],
      startTime: jsonData['startTime'],
      weekName: jsonData['weekName'],
      title: jsonData['title'],
      hallName: jsonData['hallName'],
    );
  }
}

class LectureTimetableList {
  final List<dynamic> listLectureTimetable;
  LectureTimetableList({required this.listLectureTimetable});
  factory LectureTimetableList.fromJson(Map<String, dynamic> jsonData) {
    return LectureTimetableList(
      listLectureTimetable: jsonData['lectures'],
    );
  }
}
/*
 "startDayOfStudy": "Sunday",        
            "reservationNo": 15189,
            "hallName": "Lab 2",
            "facultySemesterSubjectDetailsNo": 4101,
            "reservationTypeName": "Lecture",
            "courseId": 4101,
            "knowledgeUnitName": "Biostatistics & research",
            "facultyBatchNo": 1336,
            "facultySemesterNo": 1184,
            "nameEn": null,
            "groupNo": 7,
            "subgorupNo": null
*/