import 'package:edu_pro/models/restrictions_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class RestrictionsViewModel with ChangeNotifier {
  List<RestrictionsModel>? _RestrictionsList = [];

  Future<void> fetchRestrictions(int semesterId) async {
    _RestrictionsList = await AllApi().fetchRestrictions(semesterId);
    notifyListeners();
  }

  List<RestrictionsModel>? get RestrictionsList => _RestrictionsList;
}
