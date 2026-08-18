import 'package:flutter/material.dart';
import 'package:partfolio_app/core/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeController extends ChangeNotifier {
  final SharedPreferencesAsync sharedPreferencesAsync;
  final String themeKey = 'theme';

  late bool _isDark;

  bool get isDark => _isDark;

  AppThemeController({required this.sharedPreferencesAsync}) {
    _isDark = true;
    _loadPrefs();
  }

  switchTheme(bool value) async {
    _isDark = value;
    print("Switch theme mode => $_isDark");
    notifyListeners();
    await _savePrefs();
  }

  _loadPrefs() async {
    _isDark = await sharedPreferencesAsync.getBool(themeKey) ?? true;
    notifyListeners();
  }

  _savePrefs() async {
    await sharedPreferencesAsync.setBool(themeKey, _isDark);
  }
}
