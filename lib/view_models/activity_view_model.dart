import 'package:edu_pro/models/activitys_model.dart';
import 'package:edu_pro/services/api.dart';
import 'package:flutter/cupertino.dart';

class ActivityViewModel with ChangeNotifier {
  List<ActivitysModel>? _ActivityList = [];
  List<ActivitysModel>? _ActivitySearchList = [];

  Future<void> fetchActivity(bool isComing) async {
    _ActivityList = await Api().fetchActivity(isComing);
    notifyListeners();
  }

  Future<void> fetchSearchActivity(String start, String end) async {
    _ActivitySearchList = await Api().searchActivity(start, end);
    notifyListeners();
  }

  List<ActivitysModel>? get ActivityList => _ActivityList;
  List<ActivitysModel>? get ActivitySearchList => _ActivitySearchList;
}
