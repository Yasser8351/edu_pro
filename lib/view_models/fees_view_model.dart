// import 'package:edu_pro/models/fees_model.dart';
// import 'package:edu_pro/services/all_api.dart';
// import 'package:flutter/cupertino.dart';

// class FeesViewModel with ChangeNotifier {
//   List<FeesModel> _FeesList = [];

//   Future<void> fetchFees(int FeesId) async {
//     _FeesList = (await AllApi().fetchFees()).cast<FeesModel>();
//     notifyListeners();
//   }

//   List<FeesModel> get FeesList => _FeesList;
// }
import 'package:edu_pro/models/fees_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class FeesViewModel with ChangeNotifier {
  List<FeesModel>? _FeesList = [];

  Future<void> fetchFees(int yearId) async {
    _FeesList = (await AllApi().fetchFees(yearId));
    notifyListeners();
  }

  List<FeesModel>? get FeesList => _FeesList;
}
