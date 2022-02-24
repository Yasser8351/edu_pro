import 'package:edu_pro/models/registration_model.dart';
import 'package:edu_pro/services/api.dart';
import 'package:flutter/cupertino.dart';

class RegistrationViewModel with ChangeNotifier {
  List<RegistrationModel>? _registrationList = [];

  Future<void> fetchRegistration() async {
    _registrationList = await Api().fetchRegistration();
    notifyListeners();
  }

  List<RegistrationModel>? get registrationList => _registrationList;
}
