import 'package:edu_pro/models/profile_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class ProfileViewModel with ChangeNotifier {
  List<ProfileModel>? _ProfileList = [];

  Future<void> fetchProfile() async {
    _ProfileList = await AllApi().fetchProfile();
    notifyListeners();
  }

  List<ProfileModel>? get ProfileList => _ProfileList;
}
