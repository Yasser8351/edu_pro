import 'dart:convert';

TestModel TestModelFromJson(String str) => TestModel.fromJson(json.decode(str));

String TestModelToJson(TestModel data) => json.encode(data.toJson());

class TestModel {
  TestModel({
    required this.notes,
  });

  String notes;

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "notes": notes,
      };
}
