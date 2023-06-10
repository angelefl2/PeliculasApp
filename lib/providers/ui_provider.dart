import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme {
    return this._isDarkTheme;
  }

  set isDarkTheme(bool i) {
    this._isDarkTheme = i;
    notifyListeners();
  }
}
