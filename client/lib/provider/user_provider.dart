import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/session_manager.dart';

class UserProvider with ChangeNotifier {
  String? _userId;
  String? _userName;
  String? _userRole;
  bool _isLoggedIn = false;

  // Getters
  String? get userId => _userId;
  String? get userName => _userName;
  String? get userRole => _userRole;
  bool get isLoggedIn => _isLoggedIn;

  // Fetch user data from SharedPreferences
  Future<void> loadUserData() async {
    var userDetails = await SessionManager.getUserDetails();
    _userId = userDetails['userId'];
    _userName = userDetails['userName'];
    _userRole = userDetails['userRole'];
    _isLoggedIn = await SessionManager.isLoggedIn();

    notifyListeners();
  }

  // User login method
  Future<bool> login(String username, String password) async {
    bool result = await AuthService.login(username, password);
    if (result) {
      // Assuming the result will return user data after successful login
      // Save session information using SessionManager
      await SessionManager.saveUserSession(
        userId: 'some_user_id', // Replace with actual user ID from backend
        userName: username,
        userRole: 'patient', // Replace with actual role from backend
      );
      await loadUserData(); // Reload user data after login
    }
    return result;
  }

  // User logout method
  Future<void> logout() async {
    await SessionManager.clearSession();
    _userId = null;
    _userName = null;
    _userRole = null;
    _isLoggedIn = false;
    notifyListeners(); // Notify listeners about the state change
  }

  // Check if the user is logged in
  bool checkLoginStatus() {
    return _isLoggedIn;
  }
}
