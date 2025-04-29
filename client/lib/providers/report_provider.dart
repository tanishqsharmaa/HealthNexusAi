import 'package:flutter/material.dart';

/// A model representing a report object.
class Report {
  final String id;
  final String title;
  final String content;
  final DateTime createdAt;
  final String status;

  Report({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.status,
  });
}

/// A provider class for managing reports.
class ReportProvider with ChangeNotifier {
  final List<Report> _reports = [];
  bool _isLoading = false;

  /// Get all reports.
  List<Report> get reports => List.unmodifiable(_reports);

  /// Get loading status.
  bool get isLoading => _isLoading;

  /// Simulate fetching reports from an API or database.
  Future<void> fetchReports() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simulate a delay for fetching data
      await Future.delayed(const Duration(seconds: 2));
      _reports.clear(); // Clear existing reports
      _reports.addAll([
        Report(
          id: DateTime.now().subtract(const Duration(days: 1)).toString(),
          title: 'Report 1',
          content: 'Description of Report 1',
          createdAt: DateTime.now(),
          status: 'Pending',
        ),
        Report(
          id: DateTime.now().toString(),
          title: 'Report 2',
          content: 'Description of Report 2',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          status: 'Resolved',
        ),
      ]);
    } catch (error) {
      // Handle errors if necessary
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Add a new report.
  void addReport(String title, String content) {
    final newReport = Report(
      id: DateTime.now().toString(),
      title: title,
      content: content,
      createdAt: DateTime.now(),
      status: 'Pending',
    );
    _reports.add(newReport);
    notifyListeners();
  }

  /// Update an existing report by ID.
  void updateReport(String id, String title, String content, String status) {
    final reportIndex = _reports.indexWhere((report) => report.id == id);
    if (reportIndex != -1) {
      _reports[reportIndex] = Report(
        id: id,
        title: title,
        content: content,
        createdAt: _reports[reportIndex].createdAt,
        status: status,
      );
      notifyListeners();
    }
  }

  /// Delete a report by ID.
  void deleteReport(String id) {
    _reports.removeWhere((report) => report.id == id);
    notifyListeners();
  }

  /// Find a report by ID.
  Report? findReportById(String id) {
    return _reports.firstWhere((report) => report.id == id, orElse: () => Report(
      id: 'unknown',
      title: 'Unknown Report',
      content: 'No content available',
      createdAt: DateTime.now(),
      status: 'Unknown',
    ));
  }
}