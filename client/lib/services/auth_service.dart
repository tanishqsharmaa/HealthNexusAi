import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class AuthService {
  final String _baseUrl = Constants.apiBaseUrl; // Base URL of the API

  /// Login user with email and password
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body)['error'] ?? 'Login failed';
        throw Exception(error);
      }
    } catch (error) {
      rethrow;
    }
  }

  /// Register a new user with name, email, and password
  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    final url = Uri.parse('$_baseUrl/auth/register');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body)['error'] ?? 'Registration failed';
        throw Exception(error);
      }
    } catch (error) {
      rethrow;
    }
  }

  /// Logout user by invalidating the token (if required by the backend)
  Future<void> logout(String token) async {
    final url = Uri.parse('$_baseUrl/auth/logout');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Logout failed');
      }
    } catch (error) {
      rethrow;
    }
  }

  /// Fetch the authenticated user's profile
  Future<Map<String, dynamic>> fetchProfile(String token) async {
    final url = Uri.parse('$_baseUrl/auth/profile');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body)['error'] ?? 'Failed to fetch profile';
        throw Exception(error);
      }
    } catch (error) {
      rethrow;
    }
  }
}