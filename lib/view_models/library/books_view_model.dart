import 'package:edu_pro/models/library_model/books_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class BooksViewModel with ChangeNotifier {
  List<BooksModel>? _BooksList = [];

  Future<void> fetchBooks(String title) async {
    _BooksList = await AllApi().fetchBooks(title);
    notifyListeners();
  }

  List<BooksModel>? get BooksList => _BooksList;
}
