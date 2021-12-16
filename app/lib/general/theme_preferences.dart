import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const prefKey = "theme";

  setTheme(int value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(prefKey, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(prefKey) ?? 0;
  }
}