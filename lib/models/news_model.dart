import 'package:flutter/cupertino.dart';

/*
  public int NewsAndEventsId { get; set; }
 */
class NewsModel {
  final int? NewsAndEventsId;
  final String? programNameEn;
  final String? dateFrom;
  final String? dateTo;
  final String? NewsAndEventsTypeName;
  final String? specializationName;
  final String? facultyName;
  final String? NewsTimeFrom;
  final String? NewsTimeTo;
  final String? NewsAndEventsDescription;
  final String? batchName;
  final String? image;

  NewsModel({
    @required this.NewsAndEventsId,
    @required this.programNameEn,
    @required this.dateFrom,
    @required this.dateTo,
    @required this.NewsAndEventsTypeName,
    @required this.specializationName,
    @required this.facultyName,
    @required this.NewsTimeFrom,
    @required this.NewsTimeTo,
    @required this.NewsAndEventsDescription,
    @required this.batchName,
    @required this.image,
  });

  factory NewsModel.fromJson(Map<String, dynamic> jsonData) {
    return NewsModel(
      NewsAndEventsId: jsonData['NewsAndEventsId'] ?? 0,
      programNameEn: jsonData['programNameEn'] ?? '- - - -',
      dateFrom: jsonData['dateFrom'] ?? '- - - -',
      dateTo: jsonData['dateTo'] ?? '- - - -',
      NewsAndEventsTypeName: jsonData['newsAndEventsTypeName'] ?? '- - - -',
      specializationName: jsonData['specializationName'] ?? '- - - -',
      facultyName: jsonData['facultyName'] ?? '- - - -',
      NewsTimeFrom: jsonData['NewsTimeFrom'] ?? '- - - -',
      NewsTimeTo: jsonData['NewsTimeTo'] ?? '- - - -',
      NewsAndEventsDescription:
          jsonData['newsAndEventsDescription'] ?? '- - - -',
      batchName: jsonData['batchName'] ?? '- - - -',
      image: jsonData['mainImage'] ?? '',
    );
  }
}

class NewsList {
  final List<dynamic> listNews;
  NewsList({required this.listNews});
  factory NewsList.fromJson(Map<String, dynamic> jsonData) {
    return NewsList(
      listNews: jsonData['news'],
    );
  }
}
/*
"dateFrom": "2021-10-31T00:00:00",
            "dateTo": "2021-11-22T00:00:00",
            "NewsAndEventsTypeName": "News",
            "specializationName": "General",
            "facultyName": "Faculty of Medical Laboratory Sciences ",
            "NewsTimeFrom": "1900-01-01T09:00:00",
            "NewsTimeTo": "1900-01-01T16:00:00",
            "NewsAndEventsDescription": " القافلة الصحية العلاجية الخيرية برعاية الجامعة ",
            "batchName": "Batch30"
*/

