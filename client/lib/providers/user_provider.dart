import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  // Method to set the user data
  void setUser(UserModel user) {
    _user = user;
    notifyListeners(); // Notify listeners when the user data changes
  }

  // Method to clear the user data (e.g., on logout)
  void clearUser() {
    _user = null;
    notifyListeners(); // Notify listeners when the user data is cleared
  }

  // Simulates fetching user data from an API
  Future<void> fetchUserData(String userId) async {
    // Simulate an API request with a delay
    await Future.delayed(const Duration(seconds: 2));

    // Dummy user data for simulation
    final userData = {
      'id': userId,
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'avatarUrl': 'https://example.com/avatar.jpg',
      'phoneNumber': '1234567890',
    };

    _user = UserModel.fromJson(userData);
    notifyListeners(); // Notify listeners when the user data is fetched
  }
}