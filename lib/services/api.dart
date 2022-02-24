import 'dart:convert';
import 'dart:io';

import 'package:edu_pro/models/activitys_model.dart';
import 'package:edu_pro/models/calender_model.dart';
import 'package:edu_pro/models/card_model.dart';
import 'package:edu_pro/models/exam_model.dart';
import 'package:edu_pro/models/registration_model.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../url.dart';

class Api {
  var data;
  var Curriculum;
  late SharedPreferences _prefs;
  bool isServerError = false;

  Map<String, dynamic> responseData = {"isLogin": false, "statusCode": 200};
  //Done
  Future<List<ActivitysModel>?> fetchActivity(bool isComing) async {
    _prefs = await SharedPreferences.getInstance();
    int _facultyBatchNo = await _prefs.getInt('facultyBatchId') ?? 0;
    int _stdId = await _prefs.getInt('stdId') ?? 0;
    int _facultyNo = await _prefs.getInt('facultyNo') ?? 0;
    int _facultyProgramNo = await _prefs.getInt('facultyProgramNo') ?? 0;
    int _facultyProgramSpecializationNo =
        await _prefs.getInt('facultyProgramSpecializationNo') ?? 0;
    var url = "";

    if (isComing) {
      url =
          "$MyActivityComing?facultyNo=$_facultyNo&facultyBatchNo=$_facultyBatchNo";
      //"https://192.168.1.188:3000/api/MyActivity?facultyNo=1107&facultyBatchNo=1616";

    } else {
      url =
          "$MyActivityCurrent/current?facultyNo=$_facultyNo&facultyBatchNo=$_facultyBatchNo";
      // "https://192.168.1.188:3000/api/MyActivity?facultyNo=1107&facultyBatchNo=1616";

    }

    try {
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      http.Response response = await ioClient.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        ActivitysList news = ActivitysList.fromJson(jsonData);
        List<ActivitysModel> newsList =
            news.listActivitys.map((e) => ActivitysModel.fromJson(e)).toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<ActivitysModel>?> searchActivity(String start, String end) async {
    var url = "$MyActivitySearch?start=$start&end=$end";

    try {
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      http.Response response = await ioClient.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        ActivitysList news = ActivitysList.fromJson(jsonData);
        List<ActivitysModel> newsList =
            news.listActivitys.map((e) => ActivitysModel.fromJson(e)).toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<ExamsModel>?> fetchExams() async {
    _prefs = await SharedPreferences.getInstance();
    int _facultyBatchNo = await _prefs.getInt('facultyBatchId') ?? 0;

    var url =
        "https://192.168.1.188:3000/api/ExamsTimetable?facultyBatchId=$_facultyBatchNo";

    try {
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      http.Response response = await ioClient.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        ExamsList news = ExamsList.fromJson(jsonData);
        List<ExamsModel> newsList =
            news.listExams.map((e) => ExamsModel.fromJson(e)).toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<void> getCard() async {
    //var url = "https://192.168.1.188:3000/api/CardInfo";
    _prefs = await SharedPreferences.getInstance();

    int _stdId = await _prefs.getInt('stdId') ?? 0;

    var url = "https://192.168.1.188:3000/api/CardInfo/id?stdId=$_stdId";
    var data;
    try {
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      final response = await ioClient.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        var d = CardModel.fromJson(data);
      } else if (response.statusCode == 500) {
        isServerError = true;
      }
    } catch (error) {
      isServerError = true;
      print(error.toString());
    }
  }

  Future<void> getCurriculum() async {
    _prefs = await SharedPreferences.getInstance();

    int _facultyNo = await _prefs.getInt('facultyNo') ?? 0;
    var url =
        "https://192.168.1.188:3000/api/GetCurriculum?facultyId=$_facultyNo";
    try {
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      final response = await ioClient.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      Curriculum = json.decode(response.body);
      var _curriculum = Curriculum[0]["curriculumId"];
      await _prefs.setInt('curriculumId', _curriculum ?? 0);
    } catch (error) {
      print(error.toString());
    }
  }

//Done
  Future<bool> login(String userName, String password) async {
    var url = "http://207.180.223.113:8081/api/UserIndex";
    //var url = "https://192.168.1.188:3000/api/UserIndex";

    bool isLogin = false;
    try {
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);
      final msg = jsonEncode({

        "username": userName,
        "password": password,
        "studentIndexNo": password
      });
      http.Response response = await ioClient.post(
        Uri.parse(url),
        body: msg,
        headers: {
          'charset': 'utf-8',
          'content-type': 'text/plain',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        isLogin = true;
        responseData = {"isLogin": true, "statusCode": 200};
        data = json.decode(response.body);
      } else if (response.statusCode == 400) {
        isLogin = false;
        isServerError = false;
      } else {
        isLogin = false;
        isServerError = true;
      }
    } catch (error) {
      isServerError = true;
      responseData = {"isLogin": false, "statusCode": 500};

      isLogin = false;
    }
    return isLogin;
  }

//Done
  Future<List<CalenderModel>?> getCalender() async {
    _prefs = await SharedPreferences.getInstance();
    int _facultyBatchNo = await _prefs.getInt('facultyBatchId') ?? 0;
    int _facultyNo = await _prefs.getInt('facultyNo') ?? 0;

    var url =
        // "https://192.168.1.188:3000/api/Calendar/id?facultyNo=1107&facultyBatchNo=1616";
        "https://192.168.1.188:3000/api/Calendar/id?facultyNo=$_facultyNo&&facultyBatchNo=$_facultyBatchNo";
    try {
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      http.Response response = await ioClient.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        CalenderList products = CalenderList.fromJson(jsonData);
        List<CalenderModel> productsList = products.listCalender
            .map((e) => CalenderModel.fromJson(e))
            .toList();
        return productsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<RegistrationModel>?> fetchRegistration() async {
    var url = "https://192.168.1.188:3000/api/Registration";
    try {
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      http.Response response = await ioClient.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        RegistrationList products = RegistrationList.fromJson(jsonData);
        List<RegistrationModel> productsList = products.listRegistration
            .map((e) => RegistrationModel.fromJson(e))
            .toList();
        return productsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }
}
