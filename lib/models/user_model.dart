// To parse this JSON data, do
//
//     final userRequestResult = userRequestResultFromJson(jsonString);

import 'dart:convert';

UserRequestResult userRequestResultFromJson(String str) =>
    UserRequestResult.fromJson(json.decode(str));

String userRequestResultToJson(UserRequestResult data) =>
    json.encode(data.toJson());

class UserRequestResult {
  UserRequestResult({
    required this.status,
    required this.user,
    required this.token,
  });

  bool status;
  UserModel user;
  String token;

  factory UserRequestResult.fromJson(Map<String, dynamic> json) =>
      UserRequestResult(
        status: json["status"],
        user: UserModel.fromJson(json["user"] ?? json["data"]),
        token: json["token"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user": user.toJson(),
        "token": token,
      };
}

class UserModel {
  UserModel({
    required this.stdId,
    required this.facultyNo,
    required this.email,
    required this.facultyBatchNo,
    required this.facultySemesterNo,
    required this.facultyProgramSpecializationNo,
    required this.studentIndexNo,
    required this.facultyProgramNo,
  });

  int stdId;
  int facultyNo;
  int facultyBatchNo;
  int facultyProgramNo;
  int facultySemesterNo;
  int facultyProgramSpecializationNo;
  String studentIndexNo;
  String email;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        stdId: json["stdId"] ?? 0,
        facultyNo: json["facultyNo"] ?? 0,
        facultyBatchNo: json["facultyBatchNo"] ?? 0,
        facultyProgramNo: json["facultyProgramNo"] ?? 0,
        facultySemesterNo: json["facultySemesterNo"] ?? 0,
        facultyProgramSpecializationNo: json["facultySemesterNo"] ?? 0,
        studentIndexNo: json["studentIndexNo"] ?? '',
        email: json["email"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "stdId": stdId,
        "facultyNo": facultyNo,
        "facultyBatchNo": facultyBatchNo,
        "facultyProgramNo": facultyProgramNo,
        "facultySemesterNo": facultySemesterNo,
        "facultyProgramSpecializationNo": facultyProgramSpecializationNo,
        "studentIndexNo": studentIndexNo,
        "email": email,
      };
}
