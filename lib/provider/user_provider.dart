import 'package:edu_pro/models/user_model.dart';
import 'package:edu_pro/sharepref/user_share_pref.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  late UserModel _model;
  String _errorMessage = '';
  SharedPrefUser _sharedPref = SharedPrefUser();

  UserProvider() {
    getUserFromSharedPref();
  }

  getUserFromSharedPref() async {
    //_model = await _sharedPref.getUser();
    // _setLoadingState(LoadingState.loaded);

    notifyListeners();
  }

  // Future<UserModel> getUserFromShare() async {
  //   // var result = await SharedPrefUser().getUser();
  //   // return result;
  // }
}
