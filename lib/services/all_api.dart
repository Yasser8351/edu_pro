/**
 * GET: 200
 * POST: 201
 * PUT, PATCH, DELETE: 204
 */
import 'dart:convert';
import 'dart:io';

import 'package:edu_pro/models/curriculum_course_model.dart';
import 'package:edu_pro/models/curriculum_model.dart';
import 'package:edu_pro/models/News_model.dart';
import 'package:edu_pro/models/academic_year_model.dart';
import 'package:edu_pro/models/attendance_model.dart';
import 'package:edu_pro/models/calender_model.dart';
import 'package:edu_pro/models/card_model.dart';
import 'package:edu_pro/models/complain_model.dart';
import 'package:edu_pro/models/fees_model.dart';
import 'package:edu_pro/models/grade_system_mark_model.dart';
import 'package:edu_pro/models/grade_system_no_model.dart';
import 'package:edu_pro/models/lecture_timetable_model.dart';
import 'package:edu_pro/models/library_model/books_model.dart';
import 'package:edu_pro/models/model_library/library_brrowed_model.dart';
import 'package:edu_pro/models/model_results/result_model.dart';
import 'package:edu_pro/models/model_results/semester_model.dart';
import 'package:edu_pro/models/profile_model.dart';
import 'package:edu_pro/models/library_model/publications_model.dart';
import 'package:edu_pro/models/registration_model.dart';
import 'package:edu_pro/models/restrictions_model.dart';
import 'package:edu_pro/models/subject_attendance_model.dart';
import 'package:edu_pro/models/surveys_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../url.dart';

class AllApi {
  late SharedPreferences _prefs;

  Map<String, dynamic>? user;
  bool isServerError = false;

//Done
  Future<List<NewsModel>?> getNews([bool isComing = true]) async {
    _prefs = await SharedPreferences.getInstance();
    int universitiesId = await _prefs.getInt('universitiesId') ?? 0;
    int _facultyBatchNo = await _prefs.getInt('facultyBatchId') ?? 0;
    int _facultyNo = await _prefs.getInt('facultyNo') ?? 0;
    int _facultyProgramNo = await _prefs.getInt('facultyProgramNo') ?? 0;
    int _facultyProgramSpecializationNo =
        await _prefs.getInt('facultyProgramSpecializationNo') ?? 0;
    var url = "";
    print("universitiesId $universitiesId");
    // 1 : UMST universitie
    if (isComing) {
      url =
          "${AppSettings.URL}/api/NewsAndEvents?facultyNo=$_facultyNo&facultyBatchNo=$_facultyBatchNo";
    } else {
      url =
          "${AppSettings.URL}/api/NewsAndEvents/current?facultyNo=$_facultyNo&facultyBatchNo=$_facultyBatchNo";
    }

    print("user : $user");

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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        NewsList news = NewsList.fromJson(jsonData);
        List<NewsModel> newsList =
            news.listNews.map((e) => NewsModel.fromJson(e)).toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<CurriculumModel>?> fetchCurriculum() async {
    _prefs = await SharedPreferences.getInstance();
    int _facultyNo = await _prefs.getInt('facultyNo') ?? 0;
    int CurriculumNo = await _prefs.getInt('curriculumId') ?? 0;

    var url =
        "${AppSettings.URL}/api/FacultyMateralCurriculumn?CurriculumNo=$CurriculumNo&facultyNo=$_facultyNo";

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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        CurriculumList news = CurriculumList.fromJson(jsonData);
        List<CurriculumModel> newsList = news.listAcademicYear
            .map((e) => CurriculumModel.fromJson(e))
            .toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<CurriculumCourseModel>?> fetchCurriculumCourse() async {
    _prefs = await SharedPreferences.getInstance();
    int _facultyNo = await _prefs.getInt('facultyNo') ?? 0;
    int CurriculumNo = await _prefs.getInt('curriculumId') ?? 0;

    var url =
        "${AppSettings.URL}/api/CurriculumnCourseSpecification?CurriculumNo=$CurriculumNo";

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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        CurriculumCourseList news = CurriculumCourseList.fromJson(jsonData);
        List<CurriculumCourseModel> newsList = news.listCurriculumCourseList
            .map((e) => CurriculumCourseModel.fromJson(e))
            .toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<NewsModel>?> searchNews(String start, String end) async {
    var url = "";

    _prefs = await SharedPreferences.getInstance();

    int universitiesId = await _prefs.getInt('universitiesId') ?? 0;
    print("universitiesId $universitiesId");
    url = "${AppSettings.URL}/api/NewsAndEventsSearch?start=$start&end=$end";

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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        NewsList news = NewsList.fromJson(jsonData);
        List<NewsModel> newsList =
            news.listNews.map((e) => NewsModel.fromJson(e)).toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<GradeSystemNoModel>?> fetchGradeSystemNo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _stdId = prefs.getInt('stdId') ?? 0;
    var url = "${AppSettings.URL}/api/GradeSystem/id?stdId=$_stdId";
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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        GradeSystemNoList news = GradeSystemNoList.fromJson(jsonData);
        List<GradeSystemNoModel> newsList = news.listgradeSystemNo
            .map((e) => GradeSystemNoModel.fromJson(e))
            .toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<GradeSystemMarkModel>?> fetchGradeSystem() async {
    _prefs = await SharedPreferences.getInstance();

    int _stdId = await _prefs.getInt('stdId') ?? 0;
    var url = "${AppSettings.URL}/api/GradeSystem/id?stdId=$_stdId";
    // var url = "${AppSettings.URL}/api/GradeSystemMark/id?grade=$grade"; //20
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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        gradeSystemMarkList news = gradeSystemMarkList.fromJson(jsonData);
        List<GradeSystemMarkModel> newsList = news.listgradeSystemMark
            .map((e) => GradeSystemMarkModel.fromJson(e))
            .toList();
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final _stdId = prefs.getInt('stdId') ?? 0;
    var url = "${AppSettings.URL}/api/CardInfo/id?stdId=$_stdId";
    var data;
    try {
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      final response = await ioClient.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
      });
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        var d = CardModel.fromJson(data);
      } else if (response.statusCode == 500) {
        isServerError = true;
      }
    } catch (error) {
      print(error.toString());
    }
  }

  //Done
  Future<int> getCurrentId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var yearId;
    final _stdId = prefs.getInt('stdId') ?? 0;
    var url = "https://192.168.1.188:3000/api/AcademicYear/id?";
    var data;
    try {
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      final response = await ioClient.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
      });
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        yearId = data[0]["yearId"];

        return yearId;
        // print("data ${data["yearId"].toString()}");
      } else if (response.statusCode == 500) {
        isServerError = true;
        return 0;
      }
    } catch (error) {
      print(error.toString());
      return 0;
    }
    return yearId;
  }

//Done
  Future<List<CalenderModel>?> getCalender() async {
    _prefs = await SharedPreferences.getInstance();
    int _facultyBatchNo = await _prefs.getInt('facultyBatchId') ?? 0;
    int _facultyNo = await _prefs.getInt('facultyNo') ?? 0;
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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
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
  Future<List<SurveysModel>?> fetchSurveys() async {
    var url = "${AppSettings.URL}/api/Survey";
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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        SurveysList news = SurveysList.fromJson(jsonData);
        List<SurveysModel> newsList =
            news.listSurveys.map((e) => SurveysModel.fromJson(e)).toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<SemesterModel>?> fetchSemester() async {
    _prefs = await SharedPreferences.getInstance();
    int _facultyProgramNo = await _prefs.getInt('facultyProgramNo') ?? 0;
    var url =
        "${AppSettings.URL}/api/Semester/id?facultyProgramNo=$_facultyProgramNo"; //10075
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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        SemestersList Semester = SemestersList.fromJson(jsonData);
        List<SemesterModel> SemesterList = Semester.listSemester
            .map((e) => SemesterModel.fromJson(e))
            .toList();
        return SemesterList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<ResultModel>?> fetchResult(int semesterId) async {
    _prefs = await SharedPreferences.getInstance();
    int _stdId = await _prefs.getInt('stdId') ?? 0;
    int _facultyBatchId = await _prefs.getInt('facultyBatchId') ?? 0;
    var url =
        "${AppSettings.URL}/api/Results/id?studentNo=$_stdId&&facultyBatchId=$_facultyBatchId&&facultySemesterId=$semesterId";

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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        ResultsList Result = ResultsList.fromJson(jsonData);
        List<ResultModel> ResultList =
            Result.listResult.map((e) => ResultModel.fromJson(e)).toList();
        return ResultList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<AcademicYearModel>?> fetchAcademicYear() async {
    var url = "${AppSettings.URL}/api/AcademicYear";
    // var url = "${AppSettings.URL}/api/AcademicYear";
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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        AcademicYearList news = AcademicYearList.fromJson(jsonData);
        List<AcademicYearModel> newsList = news.listAcademicYear
            .map((e) => AcademicYearModel.fromJson(e))
            .toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<FeesModel>?> fetchFees(int yearId) async {
    _prefs = await SharedPreferences.getInstance();
    int _stdId = await _prefs.getInt('stdId') ?? 0;

    var url =
        "${AppSettings.URL}/api/FeesInformation/id?studentNo=$_stdId&&yearId=$yearId";
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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        FeesList news = FeesList.fromJson(jsonData);
        List<FeesModel> newsList =
            news.listFees.map((e) => FeesModel.fromJson(e)).toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<ProfileModel>?> fetchProfile() async {
    _prefs = await SharedPreferences.getInstance();
    int _stdId = await _prefs.getInt('stdId') ?? 0;
    //var url = "https://192.168.1.188:3000/api/MyProfile/id?stdId=67121";
    var url = "${AppSettings.URL}/api/MyProfile/id?stdId=$_stdId";
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
        ProfileList news = ProfileList.fromJson(jsonData);
        List<ProfileModel> newsList =
            news.listProfile.map((e) => ProfileModel.fromJson(e)).toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

  //Done
  Future<List<RegistrationModel>?> fetchRegistration() async {
    _prefs = await SharedPreferences.getInstance();
    int _stdId = await _prefs.getInt('stdId') ?? 0;
    //var url = "${AppSettings.URL}/api/Registration";
    var url = "http://207.180.223.113:8081/api/Registration?stdId=70390";
    //
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
        RegistrationList news = RegistrationList.fromJson(jsonData);
        List<RegistrationModel> newsList = news.listRestriction
            .map((e) => RegistrationModel.fromJson(e))
            .toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

  //Done
  Future<List<RegistrationFeesModel>?> fetchRegistrationFees() async {
    _prefs = await SharedPreferences.getInstance();
    int _stdId = await _prefs.getInt('stdId') ?? 0;
    //var url = "${AppSettings.URL}/api/Registration";
    print("_stdId $_stdId");
    var url = "https://192.168.1.188:3000/api/AcademicYear?facultyBatchId=1616";
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
        List<dynamic> list = jsonData;
        List<RegistrationFeesModel> listRegistration =
            list.map((e) => RegistrationFeesModel.fromJson(e)).toList();
        print("listRegistration $listRegistration");
        return listRegistration;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<LibraryBorrowModel>?> fetchBorrow() async {
    _prefs = await SharedPreferences.getInstance();
    int _stdId = await _prefs.getInt('stdId') ?? 0;
    var url = "${AppSettings.URL}/api/LibraryBrrowed/id?stdId=$_stdId";
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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        BorrowList news = BorrowList.fromJson(jsonData);
        List<LibraryBorrowModel> newsList =
            news.listBorrow.map((e) => LibraryBorrowModel.fromJson(e)).toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<PublicationsModel>?> fetchPublications(String bookTitle) async {
    var url = "${AppSettings.URL}/api/LibraryPublications?title=$bookTitle";
    //var url = "${AppSettings.URL}/api/LibraryPublications";

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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        PublicationsList news = PublicationsList.fromJson(jsonData);
        List<PublicationsModel> newsList = news.listPublications
            .map((e) => PublicationsModel.fromJson(e))
            .toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<BooksModel>?> fetchBooks(String title) async {
    _prefs = await SharedPreferences.getInstance();
    int _facultyNo = await _prefs.getInt('facultyNo') ?? 0;
    var url =
        // "${AppSettings.URL}/api/LibraryBooks/id?facultyNo=$_facultyNo&&bookId=1784";
        "${AppSettings.URL}/api/LibraryBooks?title=$title";
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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        BooksList news = BooksList.fromJson(jsonData);
        List<BooksModel> newsList =
            news.listBooks.map((e) => BooksModel.fromJson(e)).toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<RestrictionsModel>?> fetchRestrictions(int semesterId) async {
    _prefs = await SharedPreferences.getInstance();
    int _stdId = await _prefs.getInt('stdId') ?? 0;
    var url =
        "${AppSettings.URL}/api/Restrictions/$_stdId?stdId=$_stdId&facultySemesterId=$semesterId";
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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        RestrictionsList news = RestrictionsList.fromJson(jsonData);
        List<RestrictionsModel> newsList = news.listRestrictions
            .map((e) => RestrictionsModel.fromJson(e))
            .toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<ComplainModel>?> fetchComplain() async {
    _prefs = await SharedPreferences.getInstance();
    int _stdId = await _prefs.getInt('stdId') ?? 0;
    var url = "${AppSettings.URL}/api/Complain/$_stdId";
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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        ComplainList complain = ComplainList.fromJson(jsonData);
        List<ComplainModel> complainList = complain.listComplain
            .map((e) => ComplainModel.fromJson(e))
            .toList();
        return complainList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<bool> deleteComplain(int id) async {
    var url = "${AppSettings.URL}/api/Complain/$id";
    String message = "";
    bool isDelete = false;
    //if(204)
    try {
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      http.Response response = await ioClient.delete(
        Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      print(response.statusCode);

      if (response.statusCode == 204) {
        print(response.statusCode);
        isDelete = true;

        //message = "Deleted";
        message = "Deleted successfully";
      } else if (response.statusCode == 500) {
        message = "server error please try again later";
        isDelete = false;
        isServerError = true;
      } else {
        message = "an error occurred";
        isDelete = false;
      }
    } catch (ex) {
      print(ex);
      isDelete = false;
    }
    return isDelete;
  }

//Done
  Future<bool> sendData(String title, String complain) async {
    _prefs = await SharedPreferences.getInstance();
    int _stdId = await _prefs.getInt('stdId') ?? 0;
    bool isAdd = false;
    try {
      //var url = "https://madeinsudan2.com/update_compail.php";
      var url = "${AppSettings.URL}/api/ComplaintUpdate";
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);
      final msg = jsonEncode({
        "stdNo": _stdId,
        "complaint": complain,
        "title": title,
        "isChecked": true
      });

      http.Response response = await ioClient.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw==',
            HttpHeaders.contentTypeHeader: 'application/json'
          },
          body: msg);
      if (response.statusCode == 200) {
        print(response);
        print(response.statusCode);
        isAdd = true;
      } else if (response.statusCode == 500) {
        isServerError = true;
        isAdd = false;
      } else {
        isAdd = false;
      }
    } catch (error) {
      isAdd = false;
      print(error.toString());
    }
    return isAdd;
  }

//Done
  Future<bool> sendFeesData(
    int currencyNo,
    int semesterNo,
    int facultyInformationId,
    int academicYearNo,
    double courseFees,
    double admissionFees,
    double registrationFees,
    double trainingFees,
  ) async {
    _prefs = await SharedPreferences.getInstance();
    int _stdId = await _prefs.getInt('stdId') ?? 0;
    int _facultyBatchId = await _prefs.getInt('facultyBatchId') ?? 0;

    bool isAdd = false;
    try {
      var url = "https://192.168.1.188:3000/api/Test?FacultyBatchId=1587";
      //var url = "${AppSettings.URL}/api/ComplaintUpdate";
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);
      final msg = jsonEncode({
        "courseFees": courseFees,
        "discountRatio": 0.00,
        "finalFees": registrationFees + admissionFees + trainingFees,
        "registrartionType": 3,
        "admissionFees": admissionFees,
        "registrationFees": registrationFees,
        "paymentMethodNo": 1,
        "paymentDate": DateTime.now().toString(),
        "studentNo": 109090,
        "appNo": 0,
        "discountNote": "",
        "semesterNo": semesterNo,
        "academicYearNo": academicYearNo,
        "allFeesPaid": 0,
        "facultyInformationNo": facultyInformationId,
        "currencyNo": currencyNo, //1 SD
        "userNo": 0,
        "operationDate": DateTime.now().toString(),
        "action": "Insert New Fees",
        "note": "Student Registration from student portal app",
        "admissionDiscountRatio": 0,
        "discountReasonNo": null,
        "registrationDiscountRatio": 3,
        "externalRegistration": 3,
        "registerationSourceNo": 2,
        "registerationDate": DateTime.now().toString(),
        "trainingFees": trainingFees
      });

      http.Response response = await ioClient.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            //'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw==',
            HttpHeaders.contentTypeHeader: 'application/json'
          },
          body: msg);
      if (response.statusCode == 200) {
        isAdd = true;
      } else if (response.statusCode == 500) {
        isServerError = true;
        isAdd = false;
      } else {
        isAdd = false;
      }
    } catch (error) {
      isAdd = false;
      print(error.toString());
    }
    return isAdd;
  }

//Done
  Future<bool> updateData(int complainId, String title, String complain,
      [bool isChecked = true]) async {
    bool isAdd = false;
    _prefs = await SharedPreferences.getInstance();
    int _stdId = await _prefs.getInt('stdId') ?? 0;

    try {
      var url = "${AppSettings.URL}/api/ComplaintUpdate";
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);
      final msg = jsonEncode({
        "complaintId": complainId,
        "stdNo": _stdId,
        "complaint": complain,
        "title": title,
        "isChecked": isChecked
      });
      http.Response response = await ioClient.patch(
        Uri.parse(url),
        body: msg,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          //HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        print(response);
        print(response.statusCode);
        isAdd = true;
      } else if (response.statusCode == 500) {
        isServerError = true;
        isAdd = false;
      } else {
        isAdd = false;
      }
    } catch (error) {
      isAdd = false;
      print(error.toString());
    }
    return isAdd;
  }

//Done
  Future<void> fetchAttendance(int courseId) async {
    _prefs = await SharedPreferences.getInstance();
    int _stdId = await _prefs.getInt('stdId') ?? 0;
    var url =
        "${AppSettings.URL}/api/Curriculum/$_stdId?stdNo=$_stdId&courseId=$courseId";
    var data;
    try {
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);

      final response = await ioClient.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
      });
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        print("Attendance $data");
      } else if (response.statusCode == 500) {
        isServerError = true;
      }
    } catch (error) {
      isServerError = true;
      print(error.toString());
    }
    return data;
  }

//Done
  Future<List<AttendanceModel>?> fetchAttendanceDetails(int courseId) async {
    _prefs = await SharedPreferences.getInstance();
    int _stdId = await _prefs.getInt('stdId') ?? 0;
    var url =
        "${AppSettings.URL}/api/Curriculum?stdNo=$_stdId&courseId=$courseId";
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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        AttendanceList products = AttendanceList.fromJson(jsonData);
        List<AttendanceModel> productsList = products.listAttendance
            .map((e) => AttendanceModel.fromJson(e))
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
  Future<List<SubjectAttendanceModel>?> fetchSubjectAttendance() async {
    _prefs = await SharedPreferences.getInstance();
    int _facultyNo = await _prefs.getInt('facultyNo') ?? 0;
    int curriculumNo = await _prefs.getInt('curriculumId') ?? 0;

    var url =
        "${AppSettings.URL}/api/AttendanceSubject/id?curriculumNo=$curriculumNo"; //3735
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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        print("response.statusCode ${response.statusCode}");

        String data = response.body;
        var jsonData = jsonDecode(data);
        SubjectAttendanceList news = SubjectAttendanceList.fromJson(jsonData);
        List<SubjectAttendanceModel> newsList = news.listSubjectAttendance
            .map((e) => SubjectAttendanceModel.fromJson(e))
            .toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<List<LectureTimetableModel>?> fetchLectureTimetable(String day) async {
    _prefs = await SharedPreferences.getInstance();
    int _facultyBatchId = await _prefs.getInt('facultyBatchId') ?? 0;
    var url =
        "${AppSettings.URL}/api/LectureTimetable/id?dayName=$day&&facultyBatchNo=$_facultyBatchId"; //Saturday

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
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        String data = response.body;
        var jsonData = jsonDecode(data);
        LectureTimetableList news = LectureTimetableList.fromJson(jsonData);
        List<LectureTimetableModel> newsList = news.listLectureTimetable
            .map((e) => LectureTimetableModel.fromJson(e))
            .toList();
        return newsList;
      } else {
        return null;
      }
    } catch (ex) {
      return null;
    }
  }

//Done
  Future<bool> updateProfile(String address, String phone) async {
    _prefs = await SharedPreferences.getInstance();
    int _stdId = await _prefs.getInt('stdId') ?? 0;
    bool isUpdate = false;
    try {
      var url = "${AppSettings.URL}/api/MyProfileUpdate";
      bool trustSelfSigned = true;
      HttpClient httpClient = new HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => trustSelfSigned);
      IOClient ioClient = new IOClient(httpClient);
      final msg = jsonEncode(
          {"stdId": _stdId, "permenantAddress": address, "mobileNum": phone});
      http.Response response = await ioClient.patch(
        Uri.parse(url),
        body: msg,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          // HttpHeaders.authorizationHeader: '  Bearer ' + AppSettings.token
        },
      );
      if (response.statusCode == 200) {
        print(response);
        print(response.statusCode);
        isUpdate = true;
      } else if (response.statusCode == 500) {
        isServerError = true;
        isUpdate = false;
      } else {
        isUpdate = false;
      }
    } catch (error) {
      isUpdate = false;
      print(error.toString());
    }
    return isUpdate;
  }
}
