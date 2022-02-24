//EServices_view_model.dart EServices
import 'package:edu_pro/models/e_services_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class EServicesViewModel with ChangeNotifier {
  List<EServicesModel>? _ComplainList = [];

  Future<void> fetchEServices(int Year) async {
    _ComplainList = await AllApi().fetchEServices(Year);
    notifyListeners();
  }

  List<EServicesModel>? get EServicesList => _ComplainList;
}
