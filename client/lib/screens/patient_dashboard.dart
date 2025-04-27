import 'package:flutter/material.dart';
import '../components/patient_card.dart';
import '../components/report_card.dart';
import '../services/report_service.dart';
import '../models/report.dart';

class PatientDashboardScreen extends StatefulWidget {
  const PatientDashboardScreen({Key? key}) : super(key: key);

  @override
  State<PatientDashboardScreen> createState() => _PatientDashboardScreenState();
}

class _PatientDashboardScreenState extends State<PatientDashboardScreen> {
  bool _isLoading = true;
  List<Report> _reports = [];

  @override
  void initState() {
    super.initState();
    _fetchReports();
  }

  void _fetchReports() async {
    setState(() {
      _isLoading = true;
    });

    // Fetch the patient's reports using a service
    _reports = await ReportService.fetchPatientReports();
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to the profile screen
              Navigator.pushNamed(context, '/profile');
            },
          )
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back, Patient!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  PatientCard(),
                  const SizedBox(height: 20),
                  const Text(
                    'Your Recent Reports',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _reports.isEmpty
                      ? const Text('No reports available.')
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _reports.length,
                          itemBuilder: (context, index) {
                            return ReportCard(report: _reports[index]);
                          },
                        ),
                ],
              ),
            ),
    );
  }
}
