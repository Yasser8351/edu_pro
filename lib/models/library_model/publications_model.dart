import 'package:flutter/cupertino.dart';

class PublicationsModel {
  final int? bookId;
  final String? title;
  final String? classification;
  final String? source;
  final String? pages;
  final String? publisher;
  final String? place;
  final String? notes;
  final int? allowBorrow;

  final int? noOfCopy;

  PublicationsModel({
    this.classification,
    this.source,
    this.pages,
    this.publisher,
    this.place,
    this.notes,
    this.allowBorrow,
    this.noOfCopy,
    this.title,
    @required this.bookId,
  });

  factory PublicationsModel.fromJson(Map<String, dynamic> jsonData) {
    return PublicationsModel(
      bookId: jsonData['bookId'],
      title: jsonData['title'],
      allowBorrow: jsonData['allowBorrow'],
      classification: jsonData['classification'],
      noOfCopy: jsonData['noOfCopy'],
      notes: jsonData['notes'],
      pages: jsonData['pages'],
      place: jsonData['place'],
      publisher: jsonData['publisher'],
      source: jsonData['source'],
    );
  }
}

class PublicationsList {
  final List<dynamic> listPublications;
  PublicationsList({required this.listPublications});
  factory PublicationsList.fromJson(Map<String, dynamic> jsonData) {
    return PublicationsList(
      listPublications: jsonData['publicationsList'],
    );
  }
}
/*
           "classification": "330",
            "isbn": "81-203-1285-6",
            "source": "Asam",
            "pages": "830 Pages",
            "aquisitionTypeNo": 27,
            "publisher": "New DelhiPerntice-Hall of India ;",
            "place": "-",
            "publisherDate": null,
            "barcode": "-",
            "notes": "-",
            "specializationNo": 582,
            "noOfCopy": 5,
            "allowBorrow": 0,
*/