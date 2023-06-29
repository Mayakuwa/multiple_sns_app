// flutter
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
// constants
import 'package:first_app/constants/strings.dart';

final themeProvider = ChangeNotifierProvider((ref) => ThemeModel());

class ThemeModel extends ChangeNotifier {
  bool isDarkTheme = true;
  late SharedPreferences preferences;

  ThemeModel() {
    init();
  }

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
    final x = preferences.getBool(isDarkThemePrefsKey);
    // nullじゃない場合に取得する。
    if (x != null) isDarkTheme = x;
    notifyListeners();
  }

  Future<void> setIsDarkTheme({required bool value}) async {
    isDarkTheme = value;
    await preferences.setBool(isDarkThemePrefsKey, value);
    notifyListeners();
  }
}
