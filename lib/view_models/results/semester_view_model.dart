import 'package:edu_pro/models/model_results/semester_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class SemesterViewModel with ChangeNotifier {
  List<SemesterModel>? _SemesterList = [];
  bool _isServerError = false;

  Future<bool> fetchSemester() async {
    // _SemesterList = (await AllApi().fetchSemester())!.cast<SemesterModel>();
    _SemesterList = await AllApi().fetchSemester();

    _isServerError = await AllApi().isServerError;
    print("_isServerError $_isServerError");
    notifyListeners();
    return true;
  }

  List<SemesterModel>? get SemesterList => _SemesterList;
  bool get isServerError => _isServerError;
}
