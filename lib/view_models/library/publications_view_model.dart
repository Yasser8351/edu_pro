import 'package:edu_pro/models/library_model/publications_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class PublicationsViewModel with ChangeNotifier {
  List<PublicationsModel>? _PublicationsList = [];

  Future<void> fetchPublications(String bookTitle) async {
    _PublicationsList = await AllApi().fetchPublications(bookTitle);
    notifyListeners();
  }

  List<PublicationsModel>? get PublicationsList => _PublicationsList;
}
