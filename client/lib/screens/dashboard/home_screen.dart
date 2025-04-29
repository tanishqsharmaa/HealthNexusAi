import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/appointment_provider.dart';
import '../../models/appointment_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch appointments when the screen is initialized
    Provider.of<AppointmentProvider>(context, listen: false).fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final appointmentProvider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: appointmentProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : appointmentProvider.appointments.isEmpty
                    ? const Center(
                        child: Text('No appointments found.'),
                      )
                    : ListView.builder(
                        itemCount: appointmentProvider.appointments.length,
                        itemBuilder: (context, index) {
                          final appointment = appointmentProvider.appointments[index];
                          return AppointmentCard(appointment: appointment);
                        },
                      ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/chatList');
              },
              child: const Text('Go to Chats'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-appointment');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;

  const AppointmentCard({Key? key, required this.appointment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(appointment.title),
        subtitle: Text(
          '${appointment.description}\n${appointment.date.toLocal()}',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Text(
          appointment.status,
          style: TextStyle(
            color: appointment.status == 'Scheduled'
                ? Colors.green
                : appointment.status == 'Cancelled'
                    ? Colors.red
                    : Colors.grey,
          ),
        ),
        isThreeLine: true,
      ),
    );
  }
}