//RestrictionModel
import 'package:flutter/cupertino.dart';

class RestrictionModel {
  int? yearId;

  RestrictionModel({
    @required this.yearId,
  });

  factory RestrictionModel.fromJson(Map<String, dynamic> jsonData) {
    return RestrictionModel(
      yearId: jsonData['yearId'],
    );
  }
}

class RestrictionList {
  final List<dynamic> listRestriction;
  RestrictionList({required this.listRestriction});
  factory RestrictionList.fromJson(Map<String, dynamic> jsonData) {
    return RestrictionList(
      listRestriction: jsonData['academicList'],
    );
  }
}
