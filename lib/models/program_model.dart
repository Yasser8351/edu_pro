import 'package:flutter/cupertino.dart';

class ProgramModel {
  String? id;
  String? program;

  ProgramModel({
    @required this.id,
    @required this.program,
  });

  factory ProgramModel.fromJson(Map<String, dynamic> jsonData) {
    return ProgramModel(
      id: jsonData['id'],
      program: jsonData['program'],
    );
  }
}

class ProgramList {
  final List<dynamic> listProgram;
  ProgramList({required this.listProgram});
  factory ProgramList.fromJson(Map<String, dynamic> jsonData) {
    return ProgramList(
      listProgram: jsonData['program'],
    );
  }
}
