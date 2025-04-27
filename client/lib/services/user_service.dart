import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:health_nexus/models/user.dart';

class UserService {
  final String baseUrl = 'http://your-api-url.com'; // Replace with your backend URL

  // Function to fetch user details by userId
  Future<User?> getUserDetails(int userId) async {
    final url = Uri.parse('$baseUrl/users/$userId');
    
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // Parse the user details and return a User object
      final data = json.decode(response.body);
      return User.fromJson(data['user']);
    } else {
      // Handle the error if the user details fetch fails
      return null;
    }
  }

  // Function to update user profile
  Future<User?> updateUserProfile(int userId, Map<String, dynamic> updatedData) async {
    final url = Uri.parse('$baseUrl/users/$userId');
    
    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedData),
    );

    if (response.statusCode == 200) {
      // Parse and return the updated user profile
      final data = json.decode(response.body);
      return User.fromJson(data['user']);
    } else {
      // Handle error if the update fails
      return null;
    }
  }

  // Function to login the user (authenticate)
  Future<String?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // Parse the token or user data from the response
      final data = json.decode(response.body);
      return data['token']; // Assuming the response contains a token
    } else {
      // Return null or an error message if authentication fails
      return null;
    }
  }

  // Function to register a new user (signup)
  Future<String?> signup(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/signup');
    
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      // Parse the response and return a success message or token
      final data = json.decode(response.body);
      return data['token']; // Assuming the response contains a token
    } else {
      // Handle error if signup fails
      return null;
    }
  }

  // Function to logout the user (invalidate session)
  Future<void> logout() async {
    final url = Uri.parse('$baseUrl/auth/logout');
    
    final response = await http.post(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // Handle successful logout, clear session, etc.
      // Maybe clear any local session data
    } else {
      // Handle logout failure
      print('Logout failed');
    }
  }
}
