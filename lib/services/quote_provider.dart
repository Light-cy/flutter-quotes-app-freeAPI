import 'package:flutter/material.dart';
import 'package:quotes_app/services/quote_api_service.dart';
import 'package:quotes_app/services/quotes.dart';

class QuoteProvider extends ChangeNotifier {
  Quotes? _quotes;
  bool _isloading = false;
  String? _errmesg;

  Quotes? get quotes => _quotes;
  bool get isloading => _isloading;
  String? get errmesg => _errmesg;
  final QuotesApi _q = QuotesApi();

  QuoteProvider() {
    fetchQuote();
  }

  Future<void> fetchQuote() async {
    _isloading = true;
    _errmesg = null;
    notifyListeners();

    try {
      _quotes = await _q.getRandomQuote();
      _errmesg = null;
    } catch (e) {
      _errmesg = e.toString();
    } finally {
      _isloading = false;
      notifyListeners();
    }
  }
}
