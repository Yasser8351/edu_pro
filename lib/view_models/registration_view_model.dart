import 'package:edu_pro/models/registration_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class RegistrationViewModel with ChangeNotifier {
  List<RegistrationModel>? _RegistrationList = [];

  Future<void> fetchRegistration() async {
    _RegistrationList = (await AllApi().fetchRegistration());
    notifyListeners();
  }

  List<RegistrationModel>? get registrationList => _RegistrationList;
}
