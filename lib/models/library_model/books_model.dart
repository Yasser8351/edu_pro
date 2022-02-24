import 'package:flutter/cupertino.dart';

class BooksModel {
  final int? bookId;
  final String? title;
  final String? authors;
  final String? publisherDate;
  final String? publisher;
  final String? pages;
  final String? notes;
  final String? place;
  final int? facultyNo;

  BooksModel({
    this.pages,
    this.notes,
    this.authors,
    this.publisherDate,
    this.publisher,
    this.facultyNo,
    this.title,
    this.place,
    this.bookId,
  });

  factory BooksModel.fromJson(Map<String, dynamic> jsonData) {
    return BooksModel(
      bookId: jsonData['bookId'],
      title: jsonData['title'],
      authors: jsonData['authors'],
      publisherDate: jsonData['publisherDate'],
      publisher: jsonData['publisher'],
      facultyNo: jsonData['facultyNo'],
      pages: jsonData['pages'],
      notes: jsonData['notes'],
      place: jsonData['place'],
    );
  }
}

class BooksList {
  final List<dynamic> listBooks;
  BooksList({required this.listBooks});
  factory BooksList.fromJson(Map<String, dynamic> jsonData) {
    return BooksList(
      listBooks: jsonData['booksList'],
    );
  }
}


/*

         



bookId: 1784,
title: "Economics",
classification: "330",
isbn: "81-203-1285-6",
source: "Asam",
pages: "830 Pages",
aquisitionTypeNo: 27,
publisher: "New DelhiPerntice-Hall of India ;",
place: "-",
publisherDate: null,
barcode: "-",
notes: "-",
specializationNo: 582,
noOfCopy: 5,
allowBorrow: 0,
deposit: null,
authorNo: null,
authors: null,
shelfPlace: null,
allauthors: null,
publishDate: null,
facultyNo: 27
*/