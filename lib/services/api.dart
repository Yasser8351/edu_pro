import 'dart:convert';
import 'dart:io';

import 'package:edu_pro/models/activitys_model.dart';
import 'package:edu_pro/models/calender_model.dart';
import 'package:edu_pro/models/card_model.dart';
import 'package:edu_pro/models/exam_model.dart';
import 'package:edu_pro/models/fees_model.dart';
import 'package:edu_pro/models/model_results/result_model.dart';
import 'package:edu_pro/models/registration_model.dart';
import 'package:edu_pro/models/test_model.dart';
import 'package:edu_pro/models/universitiey_model.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../url.dart';

class Api {
  var data;
  var Curriculum;
  var university;
  late SharedPreferences _prefs;
  bool isServerError = false;

  Map<String, dynamic> responseData = {"isLogin": false, "statusCode": 200};
  //Done
  Future<List<ActivitysModel>?> fetchActivity(bool isComing) async {
    _prefs = await SharedPreferences.getInstance();
    int _facultyBatchNo = await _prefs.getInt('facultyBatchId') ?? 0;
    int _facultyNo = await _prefs.getInt('facultyNo') ?? 0;
    AppSettings.URL = await _prefs.getString('universityURL') ?? "";
    var url = "";

    if (isComing) {
      url =
          "${AppSettings.URL}/api/MyActivity?facultyNo=$_facultyNo&facultyBatchNo=$_facultyBatchNo";
    } else {
      url =
          "${AppSettings.URL}/api/MyActivity/current?facultyNo=$_facultyNo&facultyBatchNo=$_facultyBatchNo";
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
          //HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
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
    _prefs = await SharedPreferences.getInstance();
    AppSettings.URL = await _prefs.getString('universityURL') ?? "";
    var url = "${AppSettings.URL}/api/MyActivitySearch?start=$start&end=$end";

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
          //HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
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
    AppSettings.URL = await _prefs.getString('universityURL') ?? "";
    var url =
        "${AppSettings.URL}/api/ExamsTimetable?facultyBatchId=$_facultyBatchNo";

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
          //HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
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
    _prefs = await SharedPreferences.getInstance();
    int _stdId = await _prefs.getInt('stdId') ?? 0;
    _prefs = await SharedPreferences.getInstance();
    AppSettings.URL = await _prefs.getString('universityURL') ?? "";
    var url = "${AppSettings.URL}/api/CardInfo/id?stdId=$_stdId";
    var data;
    try {
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      final response = await ioClient.get(
        Uri.parse(url),
        headers: {
          'charset': 'utf-8',
          'content-type': 'text/plain',
          HttpHeaders.contentTypeHeader: 'application/json',
          //HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );

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
    AppSettings.URL = await _prefs.getString('universityURL') ?? "";

    var url = "${AppSettings.URL}/api/GetCurriculum?facultyId=$_facultyNo";
    try {
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      final response = await ioClient.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        //HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
      });
      Curriculum = json.decode(response.body);
      var _curriculum = Curriculum[0]["curriculumId"];
      await _prefs.setInt('curriculumId', _curriculum ?? 0);
    } catch (error) {
      print(error.toString());
    }
  }

//Done
  Future<bool> login(
      String universityURL, String userName, String password) async {
    _prefs = await SharedPreferences.getInstance();
    AppSettings.URL = await _prefs.getString('universityURL') ?? "";

    //"$universityURL/api/UserIndex";
    "${AppSettings.URL}/api/UserIndex";

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
        Uri.parse("$universityURL/api/UserIndex"),
        body: msg,
        headers: {
          'charset': 'utf-8',
          'content-type': 'text/plain',
          HttpHeaders.contentTypeHeader: 'application/json',
          ////HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      ).timeout(
        const Duration(seconds: 14),
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

    AppSettings.URL = await _prefs.getString('universityURL') ?? "";
    print("URL : ${AppSettings.URL}");

    var url =
        "${AppSettings.URL}/api/Calendar/id?facultyNo=$_facultyNo&&facultyBatchNo=$_facultyBatchNo";

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
          //HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
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
  Future<List<UniversitieyModel>?> getUniversities() async {
    var url = "http://207.180.223.113:8081/api/Universities";

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
          ////HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        print(data);
        var jsonData = jsonDecode(data);
        UniversitieyList products = UniversitieyList.fromJson(jsonData);
        List<UniversitieyModel> productsList = products.listUniversity
            .map((e) => UniversitieyModel.fromJson(e))
            .toList();
        return productsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

  Future<void> getImageList() async {
    try {
      bool _error = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final _stdId = prefs.getInt('stdId') ?? 0;
      var url = "https://192.168.1.188:3000/api/StudentImage?stdId=67121";
      // var url = "${AppSettings.URL}/api/MyProfile/id?stdId=$_stdId";

      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      final response = await ioClient.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
      } else {
        _error = true;
      }
    } catch (error) {}
  }

  Future<void> getRegistration() async {
    try {
      bool _error = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final _stdId = prefs.getInt('stdId') ?? 0;
      var url = "https://192.168.1.188:3000/api/Test?studentNo=671212";
      // var url = "${AppSettings.URL}/api/MyProfile/id?stdId=$_stdId";

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
        print("data ${data}");

        TestModel.fromJson(data);
      } else {
        _error = true;
      }
    } catch (error) {}
  }

//Done

  //Registration
  //https://192.168.1.188:3000/api/Test?studentNo=671212
  // Future<RegistrationModel?> fetchRegistration() async {
  //   _prefs = await SharedPreferences.getInstance();
  //   int _stdId = await _prefs.getInt('stdId') ?? 0;
  //   _prefs = await SharedPreferences.getInstance();
  //   AppSettings.URL = await _prefs.getString('universityURL') ?? "";
  //   var url = "https://192.168.1.188:3000/api/Test?studentNo=671212";
  //   // var url = "${AppSettings.URL}/api/CardInfo/id?stdId=$_stdId";
  //   var data = "";
  //   try {
  //     bool trustSelfSigned = true;
  //     HttpClient httpClient = new HttpClient()
  //       ..badCertificateCallback =
  //           ((X509Certificate cert, String host, int port) => trustSelfSigned);
  //     IOClient ioClient = new IOClient(httpClient);

  //     final response = await ioClient.get(
  //       Uri.parse(url),
  //       headers: {
  //         'charset': 'utf-8',
  //         'content-type': 'text/plain',
  //         HttpHeaders.contentTypeHeader: 'application/json',
  //         //HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       // for (Map json in data) {
  //       //   Registration photos = Registration(
  //       //       courseFees: json["courseFees"],
  //       //       discountRatio: json["discountRatio"],
  //       //       finalFees: json["finalFees"],
  //       //       registrartionType: json["registrartionType"],
  //       //       registrationFees: json["registrationFees"]);
  //       //   registrationList.add(photos);
  //       //   print("data $registrationList");
  //       // }
  //       //print("data ${response.body}");
  //       //var data = ResultModel.fromJson(jsonDecode(response.body));
  //       RegistrationModel.fromJson(jsonDecode(response.body));
  //       // print("data ${registrationModelFromJson(response.body)}");
  //       // RegistrationModel.fromJson(jsonDecode(response.body));
  //       //print(RegistrationModel.fromJson(jsonDecode(response.body)));
  //       print(response.body);
  //       return RegistrationModel.fromJson(jsonDecode(response.body));
  //     } else if (response.statusCode == 500) {
  //       isServerError = true;
  //       return null;
  //     }
  //   } catch (error) {
  //     isServerError = true;
  //     print(error.toString());
  //   }
  //   return null;
  // }

  Future<List<RegistrationModel>> fetchRegistration() async {
    var url = "https://192.168.1.188:3000/api/Test?studentNo=6712191"; //  67121
    var data = "";
    try {
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      final response = await ioClient.get(
        Uri.parse(url),
        headers: {
          'charset': 'utf-8',
          'content-type': 'text/plain',
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<RegistrationModel> list =
            data.map((json) => RegistrationModel.fromJson(json)).toList();

        print(list);
        return list;
      } else if (response.statusCode == 500) {
        isServerError = true;
        return [];
      }
    } catch (error) {
      isServerError = true;
      print(error.toString());
    }
    return [];
  }
}
