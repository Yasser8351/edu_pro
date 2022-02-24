import 'package:edu_pro/models/model_library/library_brrowed_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class LibraryBorrowViewModel with ChangeNotifier {
  List<LibraryBorrowModel>? _borrowList = [];

  Future<void> fetchBorrow() async {
    _borrowList = (await AllApi().fetchBorrow());
    notifyListeners();
  }

  List<LibraryBorrowModel>? get BorrowList => _borrowList;
}
