import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = 'https://api.example.com'; // Replace with your API's base URL
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  /// Set the Authorization token for authenticated requests
  void setAuthToken(String token) {
    _headers['Authorization'] = 'Bearer $token';
  }

  /// Generic GET request
  Future<dynamic> get(String endpoint) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    try {
      final response = await http.get(url, headers: _headers);
      return _processResponse(response);
    } catch (error) {
      rethrow;
    }
  }

  /// Generic POST request
  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    try {
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (error) {
      rethrow;
    }
  }

  /// Generic PUT request
  Future<dynamic> put(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    try {
      final response = await http.put(
        url,
        headers: _headers,
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (error) {
      rethrow;
    }
  }

  /// Generic DELETE request
  Future<dynamic> delete(String endpoint) async {
    final url = Uri.parse('$_baseUrl$endpoint');
    try {
      final response = await http.delete(url, headers: _headers);
      return _processResponse(response);
    } catch (error) {
      rethrow;
    }
  }

  /// Handles and processes HTTP responses
  dynamic _processResponse(http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode >= 200 && statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body)['error'] ?? 'Unknown Error';
      throw Exception('Error $statusCode: $error');
    }
  }
}