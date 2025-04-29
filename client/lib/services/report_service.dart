import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ReportService {
  final String _baseUrl = Constants.apiBaseUrl; // Base URL of the API

  /// Fetch all reports
  Future<List<dynamic>> fetchReports(String token) async {
    final url = Uri.parse('$_baseUrl/reports');
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
        final error = jsonDecode(response.body)['error'] ?? 'Failed to fetch reports';
        throw Exception(error);
      }
    } catch (error) {
      rethrow;
    }
  }

  /// Fetch a specific report by ID
  Future<Map<String, dynamic>> fetchReportById(String id, String token) async {
    final url = Uri.parse('$_baseUrl/reports/$id');
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
        final error = jsonDecode(response.body)['error'] ?? 'Failed to fetch report';
        throw Exception(error);
      }
    } catch (error) {
      rethrow;
    }
  }

  /// Create a new report
  Future<Map<String, dynamic>> createReport(
      Map<String, dynamic> reportData, String token) async {
    final url = Uri.parse('$_baseUrl/reports');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(reportData),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body)['error'] ?? 'Failed to create report';
        throw Exception(error);
      }
    } catch (error) {
      rethrow;
    }
  }

  /// Update a report by ID
  Future<Map<String, dynamic>> updateReport(
      String id, Map<String, dynamic> reportData, String token) async {
    final url = Uri.parse('$_baseUrl/reports/$id');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(reportData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body)['error'] ?? 'Failed to update report';
        throw Exception(error);
      }
    } catch (error) {
      rethrow;
    }
  }

  /// Delete a report by ID
  Future<void> deleteReport(String id, String token) async {
    final url = Uri.parse('$_baseUrl/reports/$id');
    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 204) {
        final error = jsonDecode(response.body)['error'] ?? 'Failed to delete report';
        throw Exception(error);
      }
    } catch (error) {
      rethrow;
    }
  }
}