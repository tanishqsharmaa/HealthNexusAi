import 'package:flutter/material.dart';
import '../models/appointment_model.dart';

class AppointmentProvider with ChangeNotifier {
  List<AppointmentModel> _appointments = [];
  bool _isLoading = false;

  List<AppointmentModel> get appointments => _appointments;
  bool get isLoading => _isLoading;

  // Method to fetch appointments from an API (simulated here)
  Future<void> fetchAppointments() async {
    _isLoading = true;
    notifyListeners(); // Notify listeners that loading state has changed

    // Simulate an API request with a delay
    await Future.delayed(const Duration(seconds: 2));

    // Dummy data for simulation
    _appointments = [
      AppointmentModel(
        id: '1',
        title: 'Doctor Appointment',
        date: DateTime.now().add(const Duration(days: 1)),
        description: 'Routine health check-up',
        location: 'City Hospital',
        status: 'Scheduled',
      ),
      AppointmentModel(
        id: '2',
        title: 'Business Meeting',
        date: DateTime.now().add(const Duration(days: 3)),
        description: 'Discuss quarterly goals',
        location: 'Downtown Office',
        status: 'Confirmed',
      ),
    ];

    _isLoading = false;
    notifyListeners(); // Notify listeners that appointments have been loaded
  }

  // Method to add a new appointment
  void addAppointment(AppointmentModel appointment) {
    _appointments.add(appointment);
    notifyListeners(); // Notify listeners about the new appointment
  }

  // Method to remove an appointment by ID
  void removeAppointment(String id) {
    _appointments.removeWhere((appointment) => appointment.id == id);
    notifyListeners(); // Notify listeners about the removed appointment
  }
}