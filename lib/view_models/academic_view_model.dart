import 'package:edu_pro/models/academic_year_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class AcademicViewModel with ChangeNotifier {
  List<AcademicYearModel>? _AcademicList = [];

  Future<void> fetchAcademic() async {
    _AcademicList = await AllApi().fetchAcademicYear();
    notifyListeners();
  }

  List<AcademicYearModel>? get AcademicList => _AcademicList;
}
