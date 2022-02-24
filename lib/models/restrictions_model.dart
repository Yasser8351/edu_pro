import 'package:flutter/cupertino.dart';

/*
  public int RestrictionsAndEventsId { get; set; }
 */
class RestrictionsModel {
  final String? activeStatus;
  final String? note;
  final String? restrictionType;

  RestrictionsModel({
    @required this.activeStatus,
    @required this.note,
    @required this.restrictionType,
  });

  factory RestrictionsModel.fromJson(Map<String, dynamic> jsonData) {
    return RestrictionsModel(
      activeStatus: jsonData['activeStatus'],
      note: jsonData['note'],
      restrictionType: jsonData['restrictionType'],
    );
  }
}

class RestrictionsList {
  final List<dynamic> listRestrictions;
  RestrictionsList({required this.listRestrictions});
  factory RestrictionsList.fromJson(Map<String, dynamic> jsonData) {
    return RestrictionsList(
      listRestrictions: jsonData['restrictionList'],
    );
  }
}
