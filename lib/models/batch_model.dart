import 'package:flutter/cupertino.dart';

class BatchModel {
  String? id;
  String? Batch;

  BatchModel({
    @required this.id,
    @required this.Batch,
  });

  factory BatchModel.fromJson(Map<String, dynamic> jsonData) {
    return BatchModel(
      id: jsonData['id'],
      Batch: jsonData['batch'],
    );
  }
}

class BatchList {
  final List<dynamic> listBatch;
  BatchList({required this.listBatch});
  factory BatchList.fromJson(Map<String, dynamic> jsonData) {
    return BatchList(
      listBatch: jsonData['batch'],
    );
  }
}
