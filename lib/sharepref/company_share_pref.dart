import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefCompany {
  late SharedPreferences _prefs;

  Future<bool> saveCompanyWhatsappNo(String companyPhone) async {
    _prefs = await SharedPreferences.getInstance();
    return await _prefs.setString('company_whatsapp', companyPhone);
  }

  Future<String?> getCompanyPhoneNo() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('company_whatsapp');
  }
}
