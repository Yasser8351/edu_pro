import 'package:edu_pro/models/surveys_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class DrawerViewModel with ChangeNotifier {
  List<SurveysModel>? _SurveysList = [];

  Future<void> fetchSurveys() async {
    _SurveysList = await AllApi().fetchSurveys();
    notifyListeners();
  }

  List<SurveysModel>? get SurveysList => _SurveysList;
}
