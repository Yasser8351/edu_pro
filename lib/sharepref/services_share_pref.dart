// import 'package:faster_faster/models/service_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPrefServices {
//   late SharedPreferences _prefs;

//   Future<bool> save(List<ServiceModel> list) async {
//     _prefs = await SharedPreferences.getInstance();
//     return await _prefs.setString('services_type', ServiceModel.encode(list));
//   }

//   Future<List<ServiceModel>> get() async {
//     _prefs = await SharedPreferences.getInstance();
//     var result = _prefs.getString('services_type');
//     return result != null ? ServiceModel.decode(result) : [];
//   }
// }
