import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/report_model.dart';
import '../../providers/report_provider.dart'; // Ensure this file contains the ReportProvider class

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch reports when the screen is initialized
    Provider.of<ReportProvider>(context, listen: false).fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              reportProvider.fetchReports();
            },
          ),
        ],
      ),
      body: reportProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : reportProvider.reports.isEmpty
              ? const Center(
                  child: Text('No reports available.'),
                )
              : ListView.builder(
                  itemCount: reportProvider.reports.length,
                  itemBuilder: (context, index) {
                    final ReportModel report = reportProvider.reports[index] as ReportModel;
                    return ReportCard(report: report);
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-report');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final ReportModel report;

  const ReportCard({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(report.title),
        subtitle: Text(
          '${report.description}\nCreated: ${report.createdAt.toLocal()}',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Text(
          report.status,
          style: TextStyle(
            color: report.status == 'Resolved'
                ? Colors.green
                : report.status == 'Pending'
                    ? Colors.orange
                    : Colors.grey,
          ),
        ),
        isThreeLine: true,
      ),
    );
  }
}