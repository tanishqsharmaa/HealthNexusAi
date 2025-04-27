import 'package:flutter/material.dart';
import '../services/chatbot_service.dart';
import '../models/chat_message.dart';

class ChatProvider with ChangeNotifier {
  List<ChatMessage> _chatMessages = [];
  bool _isLoading = false;

  List<ChatMessage> get chatMessages => _chatMessages;
  bool get isLoading => _isLoading;

  // Load initial chat messages or previous conversation
  Future<void> loadChatHistory() async {
    final chatbotService = ChatbotService();
    _chatMessages = await chatbotService.fetchChatHistory();
    notifyListeners();
  }

  // Send a new message to the backend and add to the local chat history
  Future<void> sendMessage(String message) async {
    _isLoading = true;
    notifyListeners();

    // Add the user message to the local chat
    _chatMessages.add(ChatMessage(
      sender: 'Patient', // Change accordingly based on the user type
      message: message,
      timestamp: DateTime.now(),
    ));

    // Notify listeners to update UI
    notifyListeners();

    // Call backend to get chatbot response
    String botResponse = await ChatbotService.sendMessage(message);

    // Add the bot response to the chat history
    _chatMessages.add(ChatMessage(
      sender: 'Chatbot',
      message: botResponse,
      timestamp: DateTime.now(),
    ));

    _isLoading = false;
    notifyListeners(); // Notify listeners to update UI
  }

  // Clear chat history (optional, for a new session)
  void clearChat() {
    _chatMessages.clear();
    notifyListeners();
  }
}
