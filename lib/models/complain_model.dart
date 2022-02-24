import 'package:flutter/cupertino.dart';

class ComplainModel {
  final int? complaintId;
  final String? title;
  final String? complaint;
  final bool? isChecked;

  ComplainModel({
    this.title,
    @required this.complaint,
    @required this.complaintId,
    @required this.isChecked,
  });

  factory ComplainModel.fromJson(Map<String, dynamic> jsonData) {
    return ComplainModel(
      complaintId: jsonData['complaintId'],
      title: jsonData['title'],
      complaint: jsonData['complaint'],
      isChecked: jsonData['isChecked'],
    );
  }
}

class ComplainList {
  final List<dynamic> listComplain;
  ComplainList({required this.listComplain});
  factory ComplainList.fromJson(Map<String, dynamic> jsonData) {
    return ComplainList(
      listComplain: jsonData['complains'],
    );
  }
}
