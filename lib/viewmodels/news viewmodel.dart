import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/news_item.dart';

class NewsViewModel extends ChangeNotifier {
  static const String _url = 'https://news.npcdp.de5.net/api/news';

  List<NewsItem> _newsItems = [];
  bool _loading = false;

  List<NewsItem> get newsItems => _newsItems;
  bool get loading => _loading;

  Future<void> fetchNews() async {
    _loading = true;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse(_url)).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> json = jsonDecode(response.body);
        _newsItems = json.map((e) => NewsItem.fromJson(e)).toList();
      }
    } catch (e) {
      // ignore
    }
    _loading = false;
    notifyListeners();
  }
}
