import 'dart:convert';

CardModel cardModelFromJson(String str) => CardModel.fromJson(json.decode(str));

String cardModelToJson(CardModel data) => json.encode(data.toJson());

class CardModel {
  CardModel({
    required this.stdId,
    required this.printDateTime,
    required this.printReasonText,
    required this.academicYearNo,
    required this.activeCard,
    required this.notes,
  });

  int stdId;
  DateTime printDateTime;
  String printReasonText;
  int academicYearNo;
  String activeCard;
  String notes;

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        stdId: json["stdId"],
        printDateTime: DateTime.parse(json["printDateTime"]),
        printReasonText: json["printReasonText"],
        academicYearNo: json["academicYearNo"],
        activeCard: json["activeCard"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "stdId": stdId,
        "printDateTime": printDateTime.toIso8601String(),
        "printReasonText": printReasonText,
        "academicYearNo": academicYearNo,
        "activeCard": activeCard,
        "notes": notes,
      };
}
