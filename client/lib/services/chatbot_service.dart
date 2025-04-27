import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:health_nexus/models/chat_message.dart';

class ChatbotService {
  final String baseUrl = 'http://your-api-url.com'; // Replace with your backend URL

  // Function to send a message to the chatbot and get a response
  Future<List<ChatMessage>> sendMessage(String message, int sessionId) async {
    final url = Uri.parse('$baseUrl/chatbot/message');
    
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'message': message,
        'session_id': sessionId,
      }),
    );

    if (response.statusCode == 200) {
      // Parse the response if the message is sent successfully
      final data = json.decode(response.body);
      List<ChatMessage> messages = (data['messages'] as List)
          .map((msg) => ChatMessage.fromJson(msg))
          .toList();
      
      return messages; // Return the list of messages
    } else {
      // Return an empty list if the request fails
      return [];
    }
  }

  // Function to start a new chat session
  Future<int?> startSession() async {
    final url = Uri.parse('$baseUrl/chatbot/session');
    
    final response = await http.post(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
      // Parse the session ID from the response
      final data = json.decode(response.body);
      return data['session_id']; // Return the session ID
    } else {
      // Return null if the session creation fails
      return null;
    }
  }

  // Function to fetch previous chat history
  Future<List<ChatMessage>> fetchChatHistory(int sessionId) async {
    final url = Uri.parse('$baseUrl/chatbot/session/$sessionId');
    
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // Parse the chat history from the response
      final data = json.decode(response.body);
      List<ChatMessage> messages = (data['messages'] as List)
          .map((msg) => ChatMessage.fromJson(msg))
          .toList();
      
      return messages; // Return the chat history
    } else {
      // Return an empty list if the request fails
      return [];
    }
  }
}
