import 'package:edu_pro/models/model_results/result_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class ResultViewModel with ChangeNotifier {
  List<ResultModel>? _ResultList = [];

  Future<void> fetchResult(int SemesterId) async {
    _ResultList = await AllApi().fetchResult(SemesterId);
    notifyListeners();
  }

  List<ResultModel>? get ResultList => _ResultList;
}
