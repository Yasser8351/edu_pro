import 'package:edu_pro/models/exam_model.dart';
import 'package:edu_pro/services/api.dart';
import 'package:flutter/cupertino.dart';

class ExamsViewModel with ChangeNotifier {
  List<ExamsModel>? _ExamsList = [];

  Future<void> fetchExams() async {
    _ExamsList = await Api().fetchExams();
    notifyListeners();
  }

  List<ExamsModel>? get ExamsList => _ExamsList;
}
