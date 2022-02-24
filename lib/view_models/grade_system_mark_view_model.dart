import 'package:edu_pro/models/grade_system_mark_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class GradeSystemMarkViewModel with ChangeNotifier {
  List<GradeSystemMarkModel>? _GradeSystemList = [];

  Future<void> fetchGradeSystem() async {
    _GradeSystemList = await AllApi().fetchGradeSystem();
    notifyListeners();
  }

  List<GradeSystemMarkModel>? get GradeSystemList => _GradeSystemList;
}
