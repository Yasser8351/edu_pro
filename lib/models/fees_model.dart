class FeesModel {
  final int? feesInfoId;
  final double? finalFees;
  final String? discountNote;
  final double? registrationFees;
  final double? admissionFees;
  final String? note;
  final String? paymentMethodName;
  final double? courseFees;

  FeesModel({
    this.feesInfoId,
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
      feesInfoId: jsonData['feesInfoId'] ?? 0,
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
/*
            "paymentDate": "2021-06-03T00:00:00",
            "operationDate": "2021-06-03T03:30:56.937",
            "action": "Insert New Fees",
            "registrationDiscountRatio": 0,
            "admissionDiscountRatio": 0,
            "isCurrent": true,
            "paymentMethodName": "Immediate",
            "currencyName": "SDG",
            "discountReasonNo": 0,
            "feesDiscountReason": null,
            "feesDiscountReasonId": null,
            "isDiscontinue": false,
            
    */
