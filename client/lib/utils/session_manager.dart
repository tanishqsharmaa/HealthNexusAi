import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  // Keys for storing session data
  static const String _userIdKey = 'user_id';
  static const String _userNameKey = 'user_name';
  static const String _userRoleKey = 'user_role';
  static const String _isLoggedInKey = 'is_logged_in';

  // Save user details in shared preferences
  static Future<void> saveUserSession(
      {required String userId,
      required String userName,
      required String userRole}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_userNameKey, userName);
    await prefs.setString(_userRoleKey, userRole);
    await prefs.setBool(_isLoggedInKey, true);
  }

  // Check if the user is logged in
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Get the current user details
  static Future<Map<String, String?>> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(_userIdKey);
    String? userName = prefs.getString(_userNameKey);
    String? userRole = prefs.getString(_userRoleKey);

    return {
      'userId': userId,
      'userName': userName,
      'userRole': userRole,
    };
  }

  // Remove user session (logout)
  static Future<void> clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.remove(_userNameKey);
    await prefs.remove(_userRoleKey);
    await prefs.remove(_isLoggedInKey);
  }
}
