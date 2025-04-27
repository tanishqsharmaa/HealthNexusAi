import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:health_nexus/models/user.dart';

class AuthService {
  final String baseUrl = 'http://your-api-url.com'; // Replace with your backend URL

  // Initialize secure storage to save token
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Function to handle login
  Future<User?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Parse the response if login is successful
      final data = json.decode(response.body);
      final user = User.fromJson(data['user']);
      
      // Save the JWT token securely
      await _storage.write(key: 'token', value: data['token']);
      
      return user;
    } else {
      // Return null if login fails
      return null;
    }
  }

  // Function to handle signup
  Future<bool> signup(String email, String password, String name) async {
    final url = Uri.parse('$baseUrl/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'name': name,
      }),
    );

    return response.statusCode == 201; // Return true if signup is successful
  }

  // Function to handle logout
  Future<void> logout() async {
    await _storage.delete(key: 'token'); // Delete the token from secure storage
  }

  // Function to get the token (if exists)
  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }
}
