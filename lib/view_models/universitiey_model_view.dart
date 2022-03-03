import 'package:edu_pro/models/universitiey_model.dart';
import 'package:edu_pro/services/api.dart';
import 'package:flutter/cupertino.dart';

class UniversitieyModelView with ChangeNotifier {
  List<UniversitieyModel>? _AcademicList = [];

  Future<void> fetchAcademic() async {
    _AcademicList = await Api().getUniversities();
    notifyListeners();
  }

  List<UniversitieyModel>? get AcademicList => _AcademicList;
}
