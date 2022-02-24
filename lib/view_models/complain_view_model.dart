import 'package:edu_pro/models/complain_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class ComplainViewModel with ChangeNotifier {
  List<ComplainModel>? _ComplainList = [];

  Future<void> fetchComplain() async {
    _ComplainList = await AllApi().fetchComplain();
    notifyListeners();
  }

  List<ComplainModel>? get ComplainList => _ComplainList;
}
