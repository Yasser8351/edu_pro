//EServices_view_model.dart EServices
import 'package:edu_pro/models/e-services_name.dart';
import 'package:edu_pro/models/e-services_type.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class EServicesTypeViewModel with ChangeNotifier {
  List<EServicesTypeModel>? _listType = [];
  List<EServicesNameModel>? _listName = [];

  Future<void> fetchEServices() async {
    _listType = await AllApi().fetchEServicesType();
    notifyListeners();
  }

  Future<void> fetchEServicesName() async {
    _listName = await AllApi().fetchEServicesName();
    notifyListeners();
  }

  List<EServicesTypeModel>? get listType => _listType;
  List<EServicesNameModel>? get listName => _listName;
}
