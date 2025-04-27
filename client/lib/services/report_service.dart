import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:health_nexus/models/report.dart';

class ReportService {
  final String baseUrl = 'http://your-api-url.com'; // Replace with your backend URL

  // Function to fetch a list of reports for a patient or doctor
  Future<List<Report>> getReports(int userId) async {
    final url = Uri.parse('$baseUrl/reports/user/$userId');
    
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // Parse the response to get reports
      final data = json.decode(response.body);
      List<Report> reports = (data['reports'] as List)
          .map((report) => Report.fromJson(report))
          .toList();
      
      return reports; // Return the list of reports
    } else {
      // Return an empty list if the request fails
      return [];
    }
  }

  // Function to generate a new health report
  Future<Report?> generateReport(int patientId, String reportData) async {
    final url = Uri.parse('$baseUrl/reports');
    
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'patient_id': patientId,
        'report_data': reportData,
      }),
    );

    if (response.statusCode == 201) {
      // Parse and return the generated report if successful
      final data = json.decode(response.body);
      return Report.fromJson(data['report']);
    } else {
      // Return null if report generation fails
      return null;
    }
  }

  // Function to download a report (if available in the backend as a PDF or similar)
  Future<void> downloadReport(int reportId) async {
    final url = Uri.parse('$baseUrl/reports/$reportId/download');
    
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // Handle the file download (e.g., saving to device storage)
      // You can use packages like 'path_provider' or 'flutter_downloader' for downloading files
      // Example: Save the PDF or file from response.body
    } else {
      // Handle the error if the download fails
      print('Failed to download report');
    }
  }
}
