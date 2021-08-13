import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  SharedPreferences? _prefs;
  bool _isDark = false;

  ThemeProvider() {
    this._loadFromPrefs();
  }

  void changeTheme() {
    this._isDark = !this._isDark;
    notifyListeners();
    this._saveToPrefs();
  }

  bool get isDark => this._isDark;
  ThemeData? get themeData =>
      this._isDark ? ThemeData.dark() : ThemeData.light();

  _loadFromPrefs() async {
    await _initPrefs();
    this._isDark = _prefs?.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs?.setBool('isDarkTheme', this._isDark);
  }

  _initPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }
}
