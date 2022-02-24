import 'package:flutter/cupertino.dart';

class EServicesTypeModel {
  final int? deliveryTypeId;
  final String? deliveryTypeName;
  bool? isAlwaysAvailable;

  EServicesTypeModel({
    @required this.deliveryTypeId,
    @required this.deliveryTypeName,
    @required this.isAlwaysAvailable,
  });

  factory EServicesTypeModel.fromJson(Map<String, dynamic> jsonData) {
    return EServicesTypeModel(
      deliveryTypeId: jsonData['deliveryTypeId'] ?? 0,
      deliveryTypeName: jsonData['deliveryTypeName'] ?? '',
      isAlwaysAvailable: jsonData['isAlwaysAvailable'],
    );
  }
}

class EServicesTypeList {
  final List<dynamic> listType;
  EServicesTypeList({required this.listType});
  factory EServicesTypeList.fromJson(Map<String, dynamic> jsonData) {
    return EServicesTypeList(
      listType: jsonData['type'],
    );
  }
}
