import 'package:edu_pro/models/grade_system_no_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class GradeSystemNoViewModel with ChangeNotifier {
  List<GradeSystemNoModel>? _GradeSystemList = [];

  Future<void> fetchGradeSystemNo() async {
    _GradeSystemList = await AllApi().fetchGradeSystemNo();
    notifyListeners();
  }

  List<GradeSystemNoModel>? get GradeSystemList => _GradeSystemList;
}

