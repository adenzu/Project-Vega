import 'package:flutter/material.dart';

import '../materials/themes.dart';
import 'theme_preferences.dart';

class ThemeModel extends ChangeNotifier {
  int _themeId = ThemeIds.light;
  final ThemePreferences _preferences = ThemePreferences();

  int get themeId => _themeId;

  ThemeModel() {
    getPreferences();
  }

  set themeId(int value) {
    _themeId = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _themeId = await _preferences.getTheme();
    notifyListeners();
  }
}