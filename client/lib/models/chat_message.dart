class ChatMessage {
  final int id;
  final int sessionId;  // The chat session this message belongs to
  final int? senderId;  // Sender ID (can be null for system messages)
  final String message;  // The actual text of the message
  final DateTime timestamp;  // The time when the message was sent

  ChatMessage({
    required this.id,
    required this.sessionId,
    this.senderId,
    required this.message,
    required this.timestamp,
  });

  // Factory method to create a ChatMessage instance from JSON response
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      sessionId: json['session_id'],
      senderId: json['sender_id'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']), // Convert timestamp to DateTime
    );
  }

  // Method to convert ChatMessage instance to a JSON object (for sending data)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'session_id': sessionId,
      'sender_id': senderId,
      'message': message,
      'timestamp': timestamp.toIso8601String(), // Convert DateTime to string for API
    };
  }
}
