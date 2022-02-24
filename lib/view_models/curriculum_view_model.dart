import 'package:edu_pro/models/curriculum_course_model.dart';
import 'package:edu_pro/models/curriculum_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class CurriculumViewModel with ChangeNotifier {
  List<CurriculumModel>? _CurriculumList = [];
  List<CurriculumCourseModel>? _CurriculumCourseList = [];

  Future<void> fetchCurriculum() async {
    _CurriculumList = await AllApi().fetchCurriculum();
    notifyListeners();
  }

  Future<void> fetchCurriculumCourse() async {
    _CurriculumCourseList = await AllApi().fetchCurriculumCourse();
    notifyListeners();
  }

  List<CurriculumModel>? get CurriculumList => _CurriculumList;
  List<CurriculumCourseModel>? get CurriculumCourseList =>
      _CurriculumCourseList;
}
