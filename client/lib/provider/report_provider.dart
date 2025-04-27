import 'package:flutter/material.dart';
import '../models/report.dart';
import '../services/report_service.dart';

class ReportProvider with ChangeNotifier {
  List<Report> _reports = [];
  bool _isLoading = false;

  List<Report> get reports => _reports;
  bool get isLoading => _isLoading;

  // Fetch reports for the user (patient or doctor)
  Future<void> fetchReports() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Fetch reports from the backend
      _reports = await ReportService.fetchReports();
    } catch (e) {
      // Handle error here (show a message, etc.)
      print('Error fetching reports: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Create a new report (for example, a new diagnosis or test result)
  Future<void> createReport(Report report) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Call the backend to save the new report
      final newReport = await ReportService.createReport(report);

      // Add the new report to the local list
      _reports.add(newReport);
    } catch (e) {
      // Handle error here (show a message, etc.)
      print('Error creating report: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Clear the report list (optional, for resetting the view)
  void clearReports() {
    _reports.clear();
    notifyListeners();
  }
}
