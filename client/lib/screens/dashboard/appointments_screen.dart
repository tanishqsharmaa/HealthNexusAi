import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/appointment_model.dart';
import '../../providers/appointment_provider.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch appointments when the screen is initialized
    Provider.of<AppointmentProvider>(context, listen: false).fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              appointmentProvider.fetchAppointments();
            },
          ),
        ],
      ),
      body: appointmentProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : appointmentProvider.appointments.isEmpty
              ? const Center(
                  child: Text('No appointments available.'),
                )
              : ListView.builder(
                  itemCount: appointmentProvider.appointments.length,
                  itemBuilder: (context, index) {
                    final appointment = appointmentProvider.appointments[index];
                    return AppointmentCard(appointment: appointment);
                  },
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