class Report {
  final int id;             // Unique identifier for the report
  final int patientId;      // ID of the patient the report is associated with
  final String reportType;  // Type of the report (e.g., diagnostic, lab test, etc.)
  final String description; // Description or content of the report
  final DateTime date;      // Date when the report was generated
  final String status;      // The status of the report (e.g., pending, completed)

  Report({
    required this.id,
    required this.patientId,
    required this.reportType,
    required this.description,
    required this.date,
    required this.status,
  });

  // Factory method to create a Report instance from JSON response
  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      patientId: json['patient_id'],
      reportType: json['report_type'],
      description: json['description'],
      date: DateTime.parse(json['date']),  // Convert date string to DateTime
      status: json['status'],
    );
  }

  // Method to convert a Report instance to a JSON object (for sending data)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_id': patientId,
      'report_type': reportType,
      'description': description,
      'date': date.toIso8601String(),  // Convert DateTime to string for API
      'status': status,
    };
  }
}
