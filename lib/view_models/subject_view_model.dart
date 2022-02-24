import 'package:edu_pro/models/subject_attendance_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class SubjectAttendanceViewModel with ChangeNotifier {
  List<SubjectAttendanceModel>? _SubjectAttendanceList = [];

  Future<void> fetchSubjectAttendance() async {
    _SubjectAttendanceList = await AllApi().fetchSubjectAttendance();
    notifyListeners();
  }

  List<SubjectAttendanceModel>? get SubjectAttendanceList =>
      _SubjectAttendanceList;
}
