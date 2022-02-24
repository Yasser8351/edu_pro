import 'package:flutter/cupertino.dart';

class SurveysModel {
  int? surveyId;

  SurveysModel({
    @required this.surveyId,
  });

  factory SurveysModel.fromJson(Map<String, dynamic> jsonData) {
    return SurveysModel(
      surveyId: jsonData['surveyId'],
    );
  }
}

class SurveysList {
  final List<dynamic> listSurveys;
  SurveysList({required this.listSurveys});
  factory SurveysList.fromJson(Map<String, dynamic> jsonData) {
    return SurveysList(
      listSurveys: jsonData['surveys'],
    );
  }
}
