import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  fontFamily: 'Nunito',
  useMaterial3: true,
  brightness: Brightness.light,
  colorSchemeSeed: Colors.orange,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
);

ThemeData dark = ThemeData(
  fontFamily: 'Nunito',
  useMaterial3: true,
  colorSchemeSeed: Colors.orange,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light),
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  late SharedPreferences _prefs;
  late bool _darkTheme;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _darkTheme = false;
    _loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  _loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs.getBool(key) ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs.setBool(key, _darkTheme);
  }
}
