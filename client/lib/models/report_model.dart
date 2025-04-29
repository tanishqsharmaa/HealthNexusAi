class ReportModel {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final String author;
  final String status;

  ReportModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.author,
    required this.status,
  });

  // Factory constructor to create a ReportModel from a JSON map
  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      author: json['author'] as String,
      status: json['status'] as String,
    );
  }

  // Method to convert a ReportModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'author': author,
      'status': status,
    };
  }
}