import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rapidpulse_my/model/user_model.dart';

class SessionManager {
  static const String _keyUser = 'user_session';

  // Save user session
  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toMap());
    await prefs.setString(_keyUser, userJson);
  }

  // Get user session
  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_keyUser);
    if (userJson != null) {
      return User.fromMap(jsonDecode(userJson));
    }
    return null;
  }

  // Clear user session
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUser);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_keyUser);
  }
}
