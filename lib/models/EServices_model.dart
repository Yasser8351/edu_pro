// import 'package:flutter/cupertino.dart';

// class EServicesModel {
//   int? requestsId;
//   String? note;

//   EServicesModel({
//     @required this.requestsId,
//     @required this.note,
//   });

//   factory EServicesModel.fromJson(Map<String, dynamic> jsonData) {
//     return EServicesModel(
//       requestsId: jsonData['requestsId'],
//       note: jsonData['note'],
//     );
//   }
// }

// class EServicesList {
//   final List<dynamic> listFaculty;
//   EServicesList({required this.listFaculty});
//   factory EServicesList.fromJson(Map<String, dynamic> jsonData) {
//     return EServicesList(
//       listFaculty: jsonData['eServicesRequests'],
//     );
//   }
// }

// // class EServicesList {
// //   final List<dynamic> listFaculty;
// //   EServicesList({required this.listFaculty});
// //   factory EServicesList.fromJson(Map<String, dynamic> jsonData) {
// //     return EServicesList(
// //       listFaculty: jsonData['eServicesRequests'],
// //     );
// //   }
// // }
// /*
//  "requestsId": 3,
//       "studentNo": 11,
//       "requestStatusNo": 3,
//       "date": "2019-06-18T00:00:00",
//       "paidAmmount": 300,
//       "discountAmount": 0,
//       "discountNote": null,
//       "isPaid": true,
//       "isCanceled": false,
//       "academicYearNo": 75,
//       "note": "Change third name",
//       "studentMobile": null,
//       "studentEmail": null,
//       "isStudentSource": false,
//       "isRegistrarSource": false,
//       "registrarUserNo": null
// */

import 'package:flutter/cupertino.dart';

class EServicesModel {
  int? requestsId;
  int? note;

  EServicesModel({
    @required this.requestsId,
    @required this.note,
  });

  factory EServicesModel.fromJson(Map<String, dynamic> jsonData) {
    return EServicesModel(
      requestsId: jsonData['requestsId'],
      note: jsonData['note'],
    );
  }
}

class EServicesList {
  final List<dynamic> listgradeSystemNo;
  EServicesList({required this.listgradeSystemNo});
  factory EServicesList.fromJson(Map<String, dynamic> jsonData) {
    return EServicesList(
      listgradeSystemNo: jsonData['eServicesRequests'],
    );
  }
}