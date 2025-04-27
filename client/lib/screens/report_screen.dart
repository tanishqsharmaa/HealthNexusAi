import 'package:flutter/material.dart';
import 'package:your_project/services/report_service.dart';
import 'package:your_project/models/report.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<Report>? _reports;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    try {
      // Fetch reports from backend
      List<Report> reports = await ReportService.getReports();
      setState(() {
        _reports = reports;
        _isLoading = false;
      });
    } catch (e) {
      // Handle errors (e.g., network issues)
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load reports. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        appBar: AppBar(title: Text('Reports')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pop(context); // Back to the previous screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _reports == null || _reports!.isEmpty
            ? const Center(child: Text('No reports available.'))
            : ListView.builder(
                itemCount: _reports!.length,
                itemBuilder: (context, index) {
                  final report = _reports![index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text('Report: ${report.title}'),
                      subtitle: Text('Date: ${report.date}'),
                      onTap: () {
                        // Navigate to detailed report screen
                        // You can implement this if needed
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
