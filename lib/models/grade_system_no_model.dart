import 'package:flutter/cupertino.dart';

class GradeSystemNoModel {
  int? stdId;
  int? gradeSystemNo;

  GradeSystemNoModel({
    @required this.stdId,
    @required this.gradeSystemNo,
  });

  factory GradeSystemNoModel.fromJson(Map<String, dynamic> jsonData) {
    return GradeSystemNoModel(
      stdId: jsonData['stdId'],
      gradeSystemNo: jsonData['gradeSystemNo'],
    );
  }
}

class GradeSystemNoList {
  final List<dynamic> listgradeSystemNo;
  GradeSystemNoList({required this.listgradeSystemNo});
  factory GradeSystemNoList.fromJson(Map<String, dynamic> jsonData) {
    return GradeSystemNoList(
      listgradeSystemNo: jsonData['gradeNo'],
    );
  }
}
