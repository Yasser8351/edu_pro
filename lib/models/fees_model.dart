import 'dart:convert';

class FeesModel {
  final int? feesInfonote;
  final double? finalFees;
  final String? discountNote;
  final double? registrationFees;
  final double? admissionFees;
  final String? note;
  final String? paymentMethodName;
  final double? courseFees;

  FeesModel({
    this.feesInfonote,
    this.finalFees,
    this.discountNote,
    this.registrationFees,
    this.admissionFees,
    this.note,
    this.paymentMethodName,
    this.courseFees,
  });

  factory FeesModel.fromJson(Map<String, dynamic> jsonData) {
    return FeesModel(
      courseFees: jsonData['courseFees'] ?? 0.0,
      feesInfonote: jsonData['feesInfonote'] ?? 0,
      finalFees: jsonData['finalFees'] ?? 0.0,
      discountNote: jsonData['discountNote'] ?? '-----',
      registrationFees: jsonData['registrationFees'] ?? 0.0,
      admissionFees: jsonData['admissionFees'] ?? 0.0,
      paymentMethodName: jsonData['paymentMethodName'] ?? '-----',
      note: jsonData['note'] ?? '-----',
    );
  }
}

class FeesList {
  final List<dynamic> listFees;
  FeesList({required this.listFees});
  factory FeesList.fromJson(Map<String, dynamic> jsonData) {
    return FeesList(
      listFees: jsonData['feesList'],
    );
  }
}
// // /*
// //             "paymentDate": "2021-06-03T00:00:00",
// //             "operationDate": "2021-06-03T03:30:56.937",
// //             "action": "Insert New Fees",
// //             "registrationDiscountRatio": 0,
// //             "admissionDiscountRatio": 0,
// //             "isCurrent": true,
// //             "paymentMethodName": "Immediate",
// //             "currencyName": "SDG",
// //             "discountReasonNo": 0,
// //             "feesDiscountReason": null,
// //             "feesDiscountReasonnote": null,
// //             "isDiscontinue": false,

// //     */
// // // To parse this JSON data, do
// // //
// // //     final registration = registrationFromJson(jsonString);

// // Registration registrationFromJson(String str) =>
// //     Registration.fromJson(json.decode(str));

// // String registrationToJson(Registration data) => json.encode(data.toJson());

// // class Registration {
// //   Registration({
// //     required this.registration,
// //   });

// //   List<String> registration;

// //   factory Registration.fromJson(Map<String, dynamic> json) => Registration(
// //         registration: List<String>.from(json["Registration"].map((x) => x)),
// //       );

// //   Map<String, dynamic> toJson() => {
// //         "Registration": List<dynamic>.from(registration.map((x) => x)),
// //       };
// // }
// // To parse this JSON data, do
// //
// //     final RegistrationList = RegistrationListFromJson(jsonString);

// import 'dart:convert';

// RegistrationList RegistrationListFromJson(String str) =>
//     RegistrationList.fromJson(json.decode(str));

// String RegistrationListToJson(RegistrationList data) =>
//     json.encode(data.toJson());

// class RegistrationList {
//   RegistrationList({
//     required this.areas,
//   });

//   List<Registration> areas;

//   factory RegistrationList.fromJson(Map<String, dynamic> json) =>
//       RegistrationList(
//         areas: List<Registration>.from(
//             json["data"].map((x) => Registration.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(areas.map((x) => x.toJson())),
//       };
// }

// class Registration {
//   Registration({
//     required this.note,
//     required this.name,
//     required this.fees,
//     required this.subAreas,
//   });

//   int note;
//   String name;
//   int fees;
//   List<SubRegistration> subAreas;

//   factory Registration.fromJson(Map<String, dynamic> json) => Registration(
//         note: json["note"],
//         name: json["name"],
//         fees: json["fees"],
//         subAreas: List<SubRegistration>.from(
//             json["sub_areas"].map((x) => SubRegistration.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "note": note,
//         "name": name,
//         "fees": fees,
//         "sub_areas": List<dynamic>.from(subAreas.map((x) => x.toJson())),
//       };
// }

// class SubRegistration {
//   SubRegistration({
//     required this.note,
//     required this.areanote,
//     required this.name,
//   });

//   int note;
//   int areanote;
//   String name;

//   factory SubRegistration.fromJson(Map<String, dynamic> json) =>
//       SubRegistration(
//         note: json["note"],
//         areanote: json["area_note"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "note": note,
//         "area_note": areanote,
//         "name": name,
//       };
// }

// To parse this JSON data, do
//
//     final areasRequestResult = areasRequestResultFromJson(jsonString);

AreasRequestResult areasRequestResultFromJson(String str) =>
    AreasRequestResult.fromJson(json.decode(str));

String areasRequestResultToJson(AreasRequestResult data) =>
    json.encode(data.toJson());

class AreasRequestResult {
  AreasRequestResult({
    required this.status,
    required this.areas,
  });

  bool status;
  List<AreaModel> areas;

  factory AreasRequestResult.fromJson(Map<String, dynamic> json) =>
      AreasRequestResult(
        status: json["status"],
        areas: List<AreaModel>.from(
            json["data"].map((x) => AreaModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(areas.map((x) => x.toJson())),
      };
}

class AreaModel {
  AreaModel({
    required this.note,
    required this.name,
    required this.fees,
    required this.subAreas,
  });

  int note;
  String name;
  int fees;
  List<SubAreaModel> subAreas;

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        note: json["note"],
        name: json["name"],
        fees: json["fees"],
        subAreas: List<SubAreaModel>.from(
            json["sub_areas"].map((x) => SubAreaModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "note": note,
        "name": name,
        "fees": fees,
        "sub_areas": List<dynamic>.from(subAreas.map((x) => x.toJson())),
      };
}

class SubAreaModel {
  SubAreaModel({
    required this.note,
    required this.areanote,
    required this.name,
  });

  int note;
  int areanote;
  String name;

  factory SubAreaModel.fromJson(Map<String, dynamic> json) => SubAreaModel(
        note: json["note"],
        areanote: json["area_note"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "note": note,
        "area_note": areanote,
        "name": name,
      };
}
