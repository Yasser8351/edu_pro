import 'package:edu_pro/models/attendance_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class AttendanceViewModel with ChangeNotifier {
  List<AttendanceModel>? _AttendanceList = [];

  Future<void> fetchAttendance(int courseId) async {
    _AttendanceList = await AllApi().fetchAttendanceDetails(courseId);
    notifyListeners();
  }

  List<AttendanceModel>? get AttendanceList => _AttendanceList;
}
