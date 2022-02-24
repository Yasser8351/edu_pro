import 'package:flutter/cupertino.dart';

class AttendanceModel {
  int? absenceId;
  String? studentIndexNo;
  String? courseName;
  String? attendDate;
  String? attendTime;
  String? isAbsentText;
  int? notAbsentValue;

  AttendanceModel({
    @required this.absenceId,
    @required this.studentIndexNo,
    @required this.courseName,
    @required this.attendDate,
    @required this.attendTime,
    @required this.isAbsentText,
    @required this.notAbsentValue,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> jsonData) {
    return AttendanceModel(
      absenceId: jsonData['absenceId'],
      studentIndexNo: jsonData['studentIndexNo'],
      courseName: jsonData['courseName'],
      attendDate: jsonData['attendDate'],
      attendTime: jsonData['attendTime'],
      isAbsentText: jsonData['isAbsentText'],
      notAbsentValue: jsonData['notAbsentValue'],
    );
  }
}

class AttendanceList {
  final List<dynamic> listAttendance;
  AttendanceList({required this.listAttendance});
  factory AttendanceList.fromJson(Map<String, dynamic> jsonData) {
    return AttendanceList(
      listAttendance: jsonData['absenceDetailed'],
    );
  }
}
/*

   "absenceId": 1865,
            "studentIndexNo": "MD-2020-181",
            "studentId": 61863,
            "stdNo": 61863,
            "isAbsent": true,
            "isAttended": 0,
            "isAbsentText": "Absent",
            "absentValue": 1,
            "notAbsentValue": 0,
            "totalLecture": null,
            "attended": null,
            "absent": null,
            "absencePercentage": null,
            "courseName": "Biostatistics & research",
            "attendDate": "2021-05-25T00:00:00",
            "attendTime": "1900-01-01T08:00:00",
            "courseId": 5495
*/