import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String chatTitle;

  const ChatScreen({super.key, required this.chatTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(chatTitle),
      ),
      body: Center(
        child: Text('Чат $chatTitle'),
      )
    );
  }
}
