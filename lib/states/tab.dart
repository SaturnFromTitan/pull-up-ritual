import 'package:flutter/material.dart';

class TabState extends ChangeNotifier {
  int _index = 0;
  int get index => _index;

  void setIndex(int value) {
    if (value == _index) return;
    _index = value;
    notifyListeners();
  }

  void reset() {
    setIndex(0);
  }
}
