import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/calendar_event.dart';

class CalendarViewModel extends ChangeNotifier {
  static const String _url = 'https://news.npcdp.de5.net/api/calendar';

  List<CalendarEvent> _events = [];
  bool _loading = false;

  List<CalendarEvent> get events => _events;
  bool get loading => _loading;

  Future<void> fetchCalendar() async {
    _loading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(_url)).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> json = jsonDecode(response.body);
        _events = json.map((e) => CalendarEvent.fromJson(e)).toList();
      }
    } catch (e) {
      // ignore
    }

    _loading = false;
    notifyListeners();
  }
}
