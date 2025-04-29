class AppointmentModel {
  final String id;
  final String title;
  final DateTime date;
  final String description;
  final String location;
  final String status;

  AppointmentModel({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.location,
    required this.status,
  });

  // Factory constructor to create an AppointmentModel from a JSON map
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String,
      location: json['location'] as String,
      status: json['status'] as String,
    );
  }

  // Method to convert an AppointmentModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'description': description,
      'location': location,
      'status': status,
    };
  }
}