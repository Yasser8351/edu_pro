import 'package:flutter/cupertino.dart';

class ActivitysModel {
  final int? activityTypeId;
  final String? programNameEn;
  final String? dateFrom;
  final String? dateTo;
  final String? activityName;
  final String? specializationName;
  final String? facultyName;
  final String? ActivitysTimeFrom;
  final String? ActivitysTimeTo;
  final String? ActivitysAndEventsDescription;
  final String? batchName;
  final String? image;

  ActivitysModel({
    @required this.activityTypeId,
    @required this.programNameEn,
    @required this.dateFrom,
    @required this.dateTo,
    @required this.activityName,
    @required this.specializationName,
    @required this.facultyName,
    @required this.ActivitysTimeFrom,
    @required this.ActivitysTimeTo,
    @required this.ActivitysAndEventsDescription,
    @required this.batchName,
    @required this.image,
  });

  factory ActivitysModel.fromJson(Map<String, dynamic> jsonData) {
    return ActivitysModel(
      activityTypeId: jsonData['activityTypeId'] ?? '- - - -',
      programNameEn: jsonData['programNameEn'] ?? '- - - -',
      dateFrom: jsonData['dateFrom'] ?? '- - - -',
      dateTo: jsonData['dateTo'] ?? '- - - -',
      activityName: jsonData['activityName'] ?? '- - - -',
      specializationName: jsonData['specializationName'] ?? '- - - -',
      facultyName: jsonData['facultyName'] ?? '- - - -',
      ActivitysTimeFrom: jsonData['activityTimeFrom'] ?? '- - - -',
      ActivitysTimeTo: jsonData['activityTimeTo'] ?? '- - - -',
      ActivitysAndEventsDescription:
          jsonData['activityDescription'] ?? '- - - -',
      batchName: jsonData['batchName'] ?? '- - - -',
      image: jsonData['mainImage'] ?? '- - - -',
    );
  }
}

class ActivitysList {
  final List<dynamic> listActivitys;
  ActivitysList({required this.listActivitys});
  factory ActivitysList.fromJson(Map<String, dynamic> jsonData) {
    return ActivitysList(
      listActivitys: jsonData['activity'],
    );
  }
}
/*
 dateTimeTo: "31/10/2021 - 11:03AM",
dateTimeFrom: "01/10/2021 - 9:03AM",
facultyName: "Faculty of Medical Laboratory Sciences ",
batchName: "Batch30",
facultyBatchNo: 1380,
facultyNo: 22,
dateTo: "2021-10-31T00:00:00",
dateFrom: "2021-10-01T00:00:00",
activityName: "Basketball",
activityTypeNo: 6049,
activityDescription: "Play With Professional Team<br>",
activityTimeFrom: "1900-01-01T09:03:00",
activityTimeTo: "1900-01-01T11:03:00",
studentActivityId: 45,
specializationName: "General",
programNameEn: "Master",
facultyProgramNo: 9058,
facultyProgramSpecializationNo: 11104,
facultyBatchId: 1380,
facultyProgramCode: "ML -Msc",
batchSpecializationCode: "Batch30-GN",
timeTostr: "11:03AM",
activityTimeFromStr: "9:03AM",
*/