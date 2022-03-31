import 'dart:convert';

class FeesModel {
  final int? feesInfonote;
  final double? finalFees;
  final String? discountNote;
  final double? registrationFees;
  final double? admissionFees;
  final String? note;
  final String? paymentMethodName;
  final double? courseFees;

  FeesModel({
    this.feesInfonote,
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
      feesInfonote: jsonData['feesInfonote'] ?? 0,
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
