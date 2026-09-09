import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/quote_model.dart';

class QuoteViewModel extends ChangeNotifier {
  static const String _url = 'https://sina-quote.npcdp.de5.net/aggregate';

  List<QuoteModel> _quotes = [];
  bool _loading = false;
  Timer? _pollTimer;

  List<QuoteModel> get quotes => _quotes;
  bool get loading => _loading;

  final Map<String, String> _symbolMap = {
    'hf_XAU': '现货黄金',
    'hf_XAG': '现货白银',
    'hf_CL': 'WTI美油',
    'hf_OIL': '布伦特原油',
  };

  void startPolling() {
    stopPolling();
    fetchQuotes();
    _pollTimer = Timer.periodic(const Duration(seconds: 1), (_) => fetchQuotes());
  }

  void stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  Future<void> fetchQuotes() async {
    _loading = true;
    notifyListeners();
    try {
      final response = await http.get(Uri.parse(_url)).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);
        final List<QuoteModel> results = [];
        _symbolMap.forEach((symbol, name) {
          final data = json[symbol];
          if (data != null && data is Map<String, dynamic>) {
            results.add(QuoteModel.fromJson(data, symbol, name));
          }
        });
        _quotes = results;
      }
    } catch (e) {
      // ignore
    }
    _loading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    stopPolling();
    super.dispose();
  }
}
