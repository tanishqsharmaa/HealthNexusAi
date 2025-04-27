import 'package:flutter/material.dart';

class ChatbotMessageBubble extends StatelessWidget {
  final String message;
  final bool isUserMessage;  // True if it's a user's message, false if it's chatbot's message
  final bool isLastMessage;  // True if it's the last message to add extra margin-bottom

  const ChatbotMessageBubble({
    Key? key,
    required this.message,
    required this.isUserMessage,
    this.isLastMessage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8.0,
        bottom: isLastMessage ? 16.0 : 8.0,  // Extra bottom margin if it's the last message
      ),
      child: Align(
        alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          constraints: BoxConstraints(maxWidth: 250.0),
          decoration: BoxDecoration(
            color: isUserMessage ? Colors.blueAccent : Colors.grey[300],
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: isUserMessage ? Colors.white : Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
