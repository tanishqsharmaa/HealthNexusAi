class User {
  final int id;
  final String name;
  final String email;
  final String? token; // Optional token for authentication

  User({
    required this.id,
    required this.name,
    required this.email,
    this.token, // Token is optional, as it might not always be returned
  });

  // Factory method to create a User instance from JSON response
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      token: json['token'], // Assuming token is in the response
    );
  }

  // Method to convert User instance to a JSON object (for making API requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token, // Optional token
    };
  }
}
