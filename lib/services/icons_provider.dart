import 'package:flutter/material.dart';

class IconsProvider extends ChangeNotifier {
  bool _islike = false;
  bool _isdislike = false;

  void like() {
    _islike = !_islike;
    _isdislike = false;
    notifyListeners();
  }

  void dislike() {
    _isdislike = !_isdislike;
    _islike = false;
    notifyListeners();
  }

  bool get islike => _islike;
  bool get isdislike => _isdislike;
}
