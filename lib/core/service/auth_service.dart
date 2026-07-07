import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  static const String _activeUserId = 'active_user_id';
  int? _currentUserId;
  bool get isLoggedIn => _currentUserId != null;
  int? get currentUserId => _currentUserId;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.getInt(_activeUserId);
    notifyListeners();
  }

  Future<void> setLoggedIn(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_activeUserId, userId);
    notifyListeners();
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_activeUserId);
    _currentUserId = null;
    notifyListeners();
  }
}
