import 'package:flutter/material.dart';
import '../components/patient_card.dart';
import '../components/report_card.dart';
import '../services/report_service.dart';
import '../models/report.dart';
import '../models/user.dart';

class DoctorDashboardScreen extends StatefulWidget {
  const DoctorDashboardScreen({Key? key}) : super(key: key);

  @override
  State<DoctorDashboardScreen> createState() => _DoctorDashboardScreenState();
}

class _DoctorDashboardScreenState extends State<DoctorDashboardScreen> {
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

    // Fetch the doctor’s assigned patient reports using a service
    _reports = await ReportService.fetchDoctorReports();
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              // Navigate to the profile screen
              Navigator.pushNamed(context, '/profile');
            },
          ),
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
                    'Welcome back, Doctor!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Patient Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Sample Patient Cards (could be populated dynamically)
                  PatientCard(),
                  const SizedBox(height: 20),
                  const Text(
                    'Patient Reports',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _reports.isEmpty
                      ? const Text('No reports available for your patients.')
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
