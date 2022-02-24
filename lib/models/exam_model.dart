import 'package:flutter/cupertino.dart';

class ExamsModel {
  final String? id;
  final String? title;
  final String? startDate;

  final String? endDate;

  ExamsModel({
    @required this.id,
    @required this.title,
    @required this.startDate,
    @required this.endDate,
  });

  factory ExamsModel.fromJson(Map<String, dynamic> jsonData) {
    return ExamsModel(
      id: jsonData['id'],
      endDate: jsonData['endDate'],
      startDate: jsonData['startDate'],
      title: jsonData['title'],
    );
  }
}

class ExamsList {
  final List<dynamic> listExams;
  ExamsList({required this.listExams});
  factory ExamsList.fromJson(Map<String, dynamic> jsonData) {
    return ExamsList(
      listExams: jsonData['exams'],
    );
  }
}
/*
reservationId: 15190,
reservationTypeNo: 3007,
title: "Programming languages",
startDate: "2021-09-30T00:00:00",
endDate: "2021-10-02T00:00:00",
academicYearNo: 144,
facultySemesterNo: 1184,
facultyBatchNo: 1336,
facultyNo: 20,
finished: true,
exam: true,
lecture: false,
event: false,
facultyName: "Faculty of Pharmacy",
facultyId: 20,
facultyBatchId: 1336,
batchName: "Batch22",
reservationTypeName: "Exam",
reservationTypeId: 3007,
facultyProgramSpecializationNo: 10036,
facultyProgramNo: 8015,
programNameEn: "Bachelor",
specializationName: "General",
facultyCode: "PH ",
facultyProgramCode: "PH -Bsc",
batchSpecializationCode: "Batch22-Gn"
},
*/

