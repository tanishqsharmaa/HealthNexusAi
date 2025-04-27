import 'package:flutter/material.dart';
import 'package:your_project/components/chatbot_message_bubble.dart';
import 'package:your_project/services/chatbot_service.dart';
import 'package:your_project/models/chat_message.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({Key? key}) : super(key: key);

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  TextEditingController _controller = TextEditingController();
  List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    // Add user message to the list
    setState(() {
      _messages.add(ChatMessage(
        sender: 'User',
        message: _controller.text,
        timestamp: DateTime.now(),
      ));
      _isTyping = true;
    });

    // Send message to chatbot and get response
    String chatbotResponse = await ChatbotService.sendMessage(_controller.text);

    setState(() {
      // Add chatbot's reply to the message list
      _messages.add(ChatMessage(
        sender: 'Chatbot',
        message: chatbotResponse,
        timestamp: DateTime.now(),
      ));
      _isTyping = false;
    });

    // Clear input field after sending
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat with HealthNexus AI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pop(context); // Exit to previous screen (probably dashboard)
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatbotMessageBubble(message: _messages[index]);
              },
            ),
          ),
          _isTyping
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: _sendMessage,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
