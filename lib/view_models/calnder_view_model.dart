import 'package:edu_pro/models/calender_model.dart';
import 'package:edu_pro/services/api.dart';
import 'package:flutter/cupertino.dart';

class CalenderViewModel with ChangeNotifier {
  List<CalenderModel>? _calenderList = [];

  Future<void> fetchCalender() async {
    _calenderList = await Api().getCalender();
    notifyListeners();
  }

  List<CalenderModel>? get CalenderList => _calenderList;
}
