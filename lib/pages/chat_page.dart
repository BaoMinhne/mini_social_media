import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String reciverEmail;
  final String reciverName;
  const ChatPage({
    super.key,
    required this.reciverEmail,
    required this.reciverName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          reciverName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Text("Chat with $reciverEmail"),
      ),
    );
  }
}
