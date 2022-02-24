import 'package:edu_pro/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUser {
  late SharedPreferences _prefs;
  String? image;
  Future<bool> login() async {
    _prefs = await SharedPreferences.getInstance();
    // bool userStatus = false;
    // int? stdId;
    // int? facultyNo;
    // int? facultyBatchNo;
    // int? facultyProgramNo;
    // int? facultySemesterNo;
    // int? facultyProgramSpecializationNo;
    // String? studentIndexNo;
    // await _prefs.setInt('stdId', '1');
    // await _prefs.setString('token', userModelResult.token);
    // await _prefs.setString('phone', userModelResult.user.phone);
    // await _prefs.setString('address', userModelResult.user.address);
    // await _prefs.setString('name', userModelResult.user.fullName);
    // await _prefs.setInt('sub_area_id', userModelResult.user.subAreaId);
    // await _prefs.setInt('is_active', userModelResult.user.isActive);
    // await _prefs.setInt('account_balance', userModelResult.user.accountBalance);
    // await _prefs.setInt('discount_rate', UserModel.user.discountRate);

    //await _prefs.setString('email', email);
    return await _prefs.setBool('login', true);
  }

  Future<bool> update(UserModel user) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt('stdId', user.stdId);
    // await _prefs.setString('phone', user.phone);
    // await _prefs.setString('name', user.fullName);
    // await _prefs.setString('address', user.address);
    // await _prefs.setInt('is_active', user.isActive);
    // await _prefs.setInt('sub_area_id', user.isActive);
    // await _prefs.setInt('account_balance', user.accountBalance);
    // await _prefs.setInt('discount_rate', user.discountRate);
    return await _prefs.setString('email', user.email);
  }

  Future<bool> isLogin() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('login') ?? false;
  }

  Future<int> getID() async {
    _prefs = await SharedPreferences.getInstance();
    return (_prefs.getInt('stdId') ?? -1);
  }

  Future<int> getActivityLength() async {
    _prefs = await SharedPreferences.getInstance();
    return (_prefs.getInt('ActivityList') ?? -1);
  }

  Future<int> getNewsLength() async {
    _prefs = await SharedPreferences.getInstance();
    return (_prefs.getInt('newsList') ?? -1);
  }

  Future<int> getAnnouncementsLength() async {
    _prefs = await SharedPreferences.getInstance();
    return (_prefs.getInt('announcementsList') ?? -1);
  }

  Future<int> getSurveysListLength() async {
    _prefs = await SharedPreferences.getInstance();
    return (_prefs.getInt('surveysList') ?? -1);
  }

  Future<String> getUserName() async {
    _prefs = await SharedPreferences.getInstance();
    return (_prefs.getString('firstName') ?? '');
  }

  Future<String> getImage() async {
    _prefs = await SharedPreferences.getInstance();
    return (_prefs.getString('image') ?? '');
  }

  Future<int> getUniversitiesId() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt('universitiesId') ?? 0;
  }

  Future<String> getMiddleName() async {
    _prefs = await SharedPreferences.getInstance();
    return (_prefs.getString('middleName') ?? '');
  }
  //middleName

  Future<bool> logout() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('login', false);
    return await _prefs.clear();
  }

  Future<void> clearSurveys() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt('surveysList', 0);
  }

  Future<Map<String, dynamic>> saveUser(Map<String, dynamic> user) async {
    _prefs = await SharedPreferences.getInstance();

    await _prefs.setInt('stdId', user["stdId"] ?? 0);
    await _prefs.setInt('facultyNo', user["facultyNo"] ?? 0);
    await _prefs.setInt('facultyBatchId', user["facultyBatchId"] ?? 0);
    await _prefs.setInt('facultyProgramNo', user["facultyProgramNo"] ?? 0);
    await _prefs.setInt('facultyProgramSpecializationNo',
        user["facultyProgramSpecializationNo"] ?? 0);
    await _prefs.setInt('facultySemesterId', user["facultySemesterId"] ?? 0);
    await _prefs.setString('studentIndexNo', user["studentIndexNo"] ?? '');
    await _prefs.setString('firstName', user["firstName"] ?? '');
    await _prefs.setString('middleName', user["middleName"] ?? '');
    await _prefs.setString('image', user["photoImage"] ?? '');

    return user;
  }

  Future<int> saveActivityListDrawer(int lists) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt('ActivityList', lists);
    return lists;
  }

  Future<int> saveUniversitiesId(int universitiesId) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt('universitiesId', universitiesId);
    return universitiesId;
  }

  Future<int> saveNewsListDrawer(int lists) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt('newsList', lists);
    return lists;
  }

  Future<int> saveSurveysListDrawer(int lists) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt('surveysList', lists);
    return lists;
  }

  Future<int> saveAnnouncementsListDrawer(int lists) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt('announcementsList', lists);
    return lists;
  }

  Future<Map<String, dynamic>> getUserData() async {
    Map<String, dynamic> user = {};
    _prefs = await SharedPreferences.getInstance();
    final stdId = await _prefs.getInt('stdId');
    final facultyNo = await _prefs.getInt('facultyNo');
    final facultyBatchNo = await _prefs.getInt('facultyBatchId');
    final facultyProgramNo = await _prefs.getInt('facultyProgramNo');
    final facultyProgramSpecializationNo =
        await _prefs.getInt('facultyProgramSpecializationNo');
    final facultySemesterId = await _prefs.getInt('facultySemesterNo');
    final studentIndexNo = await _prefs.getInt('studentIndexNo');
    final firstName = await _prefs.getString('firstName');

    user = {
      'stdId': stdId,
      'facultyNo': facultyNo,
      'facultyBatchId': facultyBatchNo,
      'facultyProgramNo': facultyProgramNo,
      'facultyProgramSpecializationNo': facultyProgramSpecializationNo,
      'facultySemesterId': facultySemesterId,
      'studentIndexNo': studentIndexNo,
      'firstName': firstName,
    };

    return user;
  }
}
