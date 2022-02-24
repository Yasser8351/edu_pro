import 'package:edu_pro/models/lecture_timetable_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class LectureTimetableViewModel with ChangeNotifier {
  List<LectureTimetableModel>? _LectureTimetableList = [];

  Future<void> fetchLectureTimetable(String day) async {
    _LectureTimetableList = await AllApi().fetchLectureTimetable(day);
    notifyListeners();
  }

  List<LectureTimetableModel>? get LectureTimetableList => _LectureTimetableList;
}
