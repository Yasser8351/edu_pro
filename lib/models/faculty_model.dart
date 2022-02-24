import 'package:flutter/cupertino.dart';

class FacultyModel {
  String? id;
  String? faculty;

  FacultyModel({
    @required this.id,
    @required this.faculty,
  });

  factory FacultyModel.fromJson(Map<String, dynamic> jsonData) {
    return FacultyModel(
      id: jsonData['id'],
      faculty: jsonData['faculty'],
    );
  }
}

class FacultyList {
  final List<dynamic> listFaculty;
  FacultyList({required this.listFaculty});
  factory FacultyList.fromJson(Map<String, dynamic> jsonData) {
    return FacultyList(
      listFaculty: jsonData['faculty'],
    );
  }
}
