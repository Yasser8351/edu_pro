// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
// //192.168.1.2

// class LoginProvider with ChangeNotifier {
//   List _listFaculty = [];
//   List _listBatch = [];

//   String _valueFaculty = "";
//   String _error = "";
//   String _valueBatch = "";

//   String get error => _error;

//   List get listFaculty => _listFaculty;
//   List get listBatch => _listBatch;

//   String get valueBatch => _valueBatch;
//   Map<String, String> headers = {
//     'Content-Type': 'application/json;charset=UTF-8',
//     'charset': 'UTF-8',
//     'Charset': 'utf-8'
//   };

//   Future<String?> getFaculty() async {
//     try {
//       var url = 'https://madeinsudan2.com/edu_pro/faculty.php';
//       //var url = "https://10.0.2.2:7012/api/VwFacultyBatch";

//       var response = await get(Uri.parse(url), headers: headers);

//       print(response);

//       if (response.statusCode == 200) {
//         var responseDate = json.decode(response.body);

//         _listFaculty = responseDate;

//         print('list = $_listFaculty');
//       } else {
//         print(_error);
//       }
//     } catch (error) {
//       print(error);
//     }
//     notifyListeners();
//   }

//   Future<String?> getBatch() async {
//     try {
//       var url =
//           'https://madeinsudan2.com/edu_pro/faculty2.php?id=$_valueFaculty';
//       //https://127.0.0.1:7012/api/VwFacultyBatch
//       //get(Uri.parse(url));

//       var response = await http.post(Uri.parse(url));
//       var responseDate = json.decode(response.body);

//       _listBatch = responseDate['batch'];

//       print('list = $listBatch');
//     } catch (error) {
//       print(error);
//     }
//   }

//   Future<String?> getAnnouncement() async {
//     try {
//       var url = 'https://10.0.2.2:7012/api/Announcement/57392';
//       //https://127.0.0.1:7012/api/VwFacultyBatch
//       //get(Uri.parse(url));

//       var response = await http.post(Uri.parse(url));
//       var responseDate = json.decode(response.body);
//       print("object");
//       print(response);
//     } catch (error) {
//       print(error);
//     }
//   }
// }
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';

class LoginProvider with ChangeNotifier {
  List _listFaculty = [];
  List _listBatch = [];
  List _listProgram = [];
  String _errorMessage = "";
  bool _isLoading = false;
  bool _isLogin = false;

  List get listFaculty => _listFaculty;
  List get listBatch => _listBatch;
  List get listProgram => _listProgram;
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  bool get isLogin => _isLogin;

  // Future<String?> getFaculty() async {
  //   try {
  //     //var url = 'https://madeinsudan2.com/edu_pro/faculty.php';
  //     var url = "https://10.0.2.2:7012/api/faculty";

  //     var response = await get(Uri.parse(url));
  //     print(response);

  //     if (response.statusCode == 200) {
  //       var responseDate = json.decode(response.body);

  //       _listFaculty = responseDate;
  //       //_listFaculty = responseDate['faculty'];

  //       print('list Faculty = $_listFaculty');
  //     } else {
  //       _errorMessage = response.statusCode.toString();
  //     }
  //   } catch (error) {
  //     _errorMessage = error.toString();
  //   }
  // }

  Future<void> getFaculty() async {
    _isLoading = true;
    var url = "https://192.168.1.2:3000/api/faculty";

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
        var responseDate = json.decode(response.body);
        _listFaculty = responseDate;
        print("_listFaculty = $_listFaculty");
        _isLoading = false;
      } else {
        _isLoading = false;
      }
    } catch (error) {
      _isLoading = false;

      print(error.toString());
      notifyListeners();
    }
  }

  Future<void> getProgram(int facultyNo) async {
    var url =
        "https://192.168.1.2:3000/api/VwFacultyProgram/id?facultyNo=$facultyNo";

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
        var responseDate = json.decode(response.body);
        _listProgram = responseDate;
        print("_listProgram = $_listProgram");
        _isLoading = false;
      } else {
        _isLoading = false;
      }
    } catch (error) {
      _isLoading = false;

      print(error.toString());
      notifyListeners();
    }
  }

  Future<void> getBatch(int facultyNo, int facultyProgramNo) async {
    var url =
        //        "https://192.168.1.2:3000/api/VwBatchSemester/id?facultyNo=988&&&facultyProgramNo=803";

        "https://192.168.1.2:3000/api/VwBatchSemester/id?facultyNo=$facultyNo&&&facultyProgramNo=$facultyProgramNo";

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
        var responseDate = json.decode(response.body);
        _listBatch = responseDate;
        print("_listProgram = $_listBatch");
        _isLoading = false;
      } else {
        _isLoading = false;
      }
    } catch (error) {
      _isLoading = false;

      print(error.toString());
      notifyListeners();
    }
  }

  Future<void> userLogin(String userName, String password) async {
    try {
      var url =
          "https://192.168.1.2:3000/api/User/id?userName=$userName&&password=$password&&facultyId=23&&facultyProgramId=8018";
      // 'https://madeinsudan2.com/edu_pro/faculty2.php?userName=$userName&&password=$password';
      //"https://192.168.1.2:3000/api/User/id?userName=faisal&&password=fFi45zKhzawfnoVaamRN/Q==&&facultyId=23&&facultyProgramId=8018";

      var response = await post(Uri.parse(url));
      if (response.statusCode == 200) {
        _isLogin = true;
        _isLoading = true;
      } else {
        _isLogin = false;
        _isLoading = false;
        _errorMessage = response.statusCode.toString();
      }
    } catch (error) {
      _isLogin = false;
      _isLoading = false;
      _errorMessage = error.toString();
      print(error);
    }
  }

  Future<String> login(String userName, String password) async {
    var url =
        "https://192.168.1.2:3000/api/User/id?userName=$userName&&password=$password";
    //https://192.168.1.2:3000/api/User/id?userName=faisal&password=fFi45zKhzawfnoVaamRN/Q==
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
      // var response = await post(
      //   Uri.parse(url),
      // );
      data = json.decode(response.body);
      print(data);
    } catch (error) {
      print(error.toString());
    }
    return data;
  }
}

//   Future<String?> getAnnouncement() async {
//     try {
//       var url = 'https://10.0.2.2:7012/api/Announcement/57392';
//       //https://127.0.0.1:7012/api/VwFacultyBatch
//       //get(Uri.parse(url));
//       var response = await http.post(Uri.parse(url));
//       var responseDate = json.decode(response.body);
//       print("object");
//       print(response);
//     } catch (error) {
//       print(error);
//     }
//   }
// }
