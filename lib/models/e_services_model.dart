import 'package:flutter/cupertino.dart';

class EServicesModel {
  final int? requestsId;

  final int? requestStatusNo;

  final String? note;
  final String? date;
  final int? paidAmmount;
  final int? discountAmount;
  final int? price;

  final bool? isPaid;
  final bool? isCanceled;
  final String? requestStatusName;

  EServicesModel({
    this.requestStatusNo,
    this.date,
    this.paidAmmount,
    this.discountAmount,
    this.isPaid,
    this.isCanceled,
    this.requestStatusName,
    this.price,
    @required this.requestsId,
    @required this.note,
  });

  factory EServicesModel.fromJson(Map<String, dynamic> jsonData) {
    return EServicesModel(
      requestsId: jsonData['requestsId'] ?? 0,
      requestStatusName: jsonData['requestStatusName'] ?? '',
      date: jsonData['date'] ?? '',
      discountAmount: jsonData['discountAmount'] ?? 0,
      isCanceled: jsonData['isCanceled'] ?? false,
      isPaid: jsonData['isPaid'] ?? false,
      paidAmmount: jsonData['paidAmmount'] ?? 0,
      note: jsonData['note'] ?? '',
      requestStatusNo: jsonData['requestStatusNo'] ?? 0,
      price: jsonData['price'] ?? 0,
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
/*

 "requestStatusName": "Delivered",
      "serviceTypeNo": 1,
      "requestsNo": 3,
      "isPaid": true,
      "requestStatusNo": 4,
      "servicesTypeName": "Freeze Request",
      "price": 100,
      "isGraduate": false,
      "isBoth": false,
      "hasChangeInformation": true,
      "requirements": "q",
      "hasRequirements": true,
      "isDelivered": true,
      "isFinished": false,
      "isInProgress": false,
      "isPending": false,
      "date": "2019-06-18T00:00:00",
      "servicesTypeId": 1,
      "studentNo": 11,
      "paidAmount": 100,
      "servicePaymentStatus": "Paid",
      "fullName": null,
      "studentIndexNo": null,
      "academicYearNo": 75,
      "isCanceled": false
*/