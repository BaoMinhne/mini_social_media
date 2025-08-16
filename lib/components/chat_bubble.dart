import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    final isImage = message.startsWith('http') &&
        (message.contains('.jpg') ||
            message.contains('.png') ||
            message.contains('cloudinary'));
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.green : Colors.grey[500],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(isCurrentUser ? 12 : 0),
            bottomRight: Radius.circular(isCurrentUser ? 0 : 12),
          ),
        ),
        child: isImage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  message,
                  fit: BoxFit.cover,
                ),
              )
            : Text(
                message,
                style: TextStyle(
                  color: isCurrentUser ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
