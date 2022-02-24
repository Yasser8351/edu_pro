import 'package:flutter/cupertino.dart';

class ResultModel {
  String? resultId;
  String? courseName;
  String? grade;

  ResultModel({
    @required this.resultId,
    @required this.courseName,
    @required this.grade,
  });

  factory ResultModel.fromJson(Map<String, dynamic> jsonData) {
    return ResultModel(
      resultId: jsonData['studentIndexNo'],
      courseName: jsonData['knowledgeUnitName'],
      grade: jsonData['grade'],
    );
  }
}

class ResultsList {
  final List<dynamic> listResult;
  ResultsList({required this.listResult});
  factory ResultsList.fromJson(Map<String, dynamic> jsonData) {
    return ResultsList(
      listResult: jsonData['results'],
    );
  }
}
