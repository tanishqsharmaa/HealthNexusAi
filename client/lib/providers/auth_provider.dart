import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String _token = '';
  String _userId = '';
  bool _isAuthenticated = false;

  String get token => _token;
  String get userId => _userId;
  bool get isAuthenticated => _isAuthenticated;

  // Simulates a login process
  Future<void> login(String email, String password) async {
    // Simulate an API request for authentication
    await Future.delayed(const Duration(seconds: 2));

    // Dummy authentication logic
    if (email == 'test@example.com' && password == 'password123') {
      _isAuthenticated = true;
      _token = 'dummy_token';
      _userId = 'dummy_user_id';

      notifyListeners(); // Notify listeners about state changes
    } else {
      throw Exception('Invalid email or password');
    }
  }

  // Simulates a logout process
  void logout() {
    _isAuthenticated = false;
    _token = '';
    _userId = '';

    notifyListeners(); // Notify listeners about state changes
  }
}