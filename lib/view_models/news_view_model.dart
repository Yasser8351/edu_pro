import 'package:edu_pro/models/News_model.dart';
import 'package:edu_pro/services/all_api.dart';
import 'package:flutter/cupertino.dart';

class NewsViewModel with ChangeNotifier {
  List<NewsModel>? _NewsList = [];
  List<NewsModel>? _NewsSearchList = [];

  Future<void> fetchNews([bool isComing = true]) async {
    _NewsList = await AllApi().getNews(isComing);
    notifyListeners();
  }

  Future<void> fetchSearchNews(String start, String end) async {
    _NewsSearchList = (await AllApi().searchNews(start, end));

    notifyListeners();
  }

  List<NewsModel>? get NewsList => _NewsList;

  List<NewsModel>? get NewsSearchList => _NewsSearchList;
}
