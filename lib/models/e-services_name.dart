import 'package:flutter/cupertino.dart';

class EServicesNameModel {
  final int? servicesTypeId;
  final String? servicesTypeName;
  bool? isAlwaysAvailable = false;

  EServicesNameModel({
    @required this.servicesTypeId,
    @required this.servicesTypeName,
    @required this.isAlwaysAvailable,
  });

  factory EServicesNameModel.fromJson(Map<String, dynamic> jsonData) {
    return EServicesNameModel(
      servicesTypeId: jsonData['servicesTypeId'] ?? 0,
      servicesTypeName: jsonData['servicesTypeName'] ?? '',
      isAlwaysAvailable: jsonData['isAlwaysAvailable'] ?? false,
    );
  }
}

class EServicesNameList {
  final List<dynamic> listName;
  EServicesNameList({required this.listName});
  factory EServicesNameList.fromJson(Map<String, dynamic> jsonData) {
    return EServicesNameList(
      listName: jsonData['servicesType'],
    );
  }
}
