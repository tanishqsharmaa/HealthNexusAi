import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> chats = [
      {
        'name': 'Alice',
        'lastMessage': 'Hey, how are you?',
        'time': '10:30 AM',
        'avatarUrl': 'https://example.com/avatar1.jpg',
      },
      {
        'name': 'Bob',
        'lastMessage': 'Let\'s catch up later!',
        'time': 'Yesterday',
        'avatarUrl': 'https://example.com/avatar2.jpg',
      },
      {
        'name': 'Charlie',
        'lastMessage': 'Thanks for the help!',
        'time': '2 days ago',
        'avatarUrl': 'https://example.com/avatar3.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ChatItem(
            name: chat['name']!,
            lastMessage: chat['lastMessage']!,
            time: chat['time']!,
            avatarUrl: chat['avatarUrl']!,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to new chat screen
          Navigator.pushNamed(context, '/new-chat');
        },
        child: const Icon(Icons.message),
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final String avatarUrl;

  const ChatItem({
    Key? key,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(avatarUrl),
        radius: 24,
      ),
      title: Text(name),
      subtitle: Text(lastMessage),
      trailing: Text(
        time,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      onTap: () {
        // Navigate to chat detail screen
        Navigator.pushNamed(context, '/chat-detail', arguments: name);
      },
    );
  }
}