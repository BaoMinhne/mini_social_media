import 'package:flutter/material.dart';
import 'package:mini_social_media/components/chat_bubble.dart';
import 'package:mini_social_media/components/my_user_input.dart';
import 'package:mini_social_media/services/chat/chat_service.dart';
import 'package:mini_social_media/services/img/image_service.dart';

class ChatPage extends StatefulWidget {
  final String reciverEmail;
  final String reciverName;
  ChatPage({
    super.key,
    required this.reciverEmail,
    required this.reciverName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // têxt controller for message input
  final TextEditingController _messageController = TextEditingController();

  // chat service
  final ChatService chatService = ChatService();

  // send message function
  void sendMessage() async {
    // check there is something in the textfield
    if (_messageController.text.isNotEmpty) {
      String message = _messageController.text;
      await chatService.sendMessage(widget.reciverEmail, message);
      // clear the text field after sending
      _messageController.clear();
    }
  }

  void pickAndSendImage() async {
    final imageUrl = await ImageService.pickAndUploadImage();
    if (imageUrl != null) {
      await chatService.sendMessage(widget.reciverEmail, imageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.reciverName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const SizedBox(height: 10),
          // display messages
          Expanded(child: _buildMessagesList()),
          // user input field
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return StreamBuilder(
      stream: chatService.getMessages(
          chatService.currentUser!.email!, widget.reciverEmail),
      builder: (context, snapshot) {
        // check for errors
        if (snapshot.hasError) {
          return Center(child: Text('Error loading messages'));
        }
        // show loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // return list view
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // check if the message is sent by the current user
    bool isCurrentUser = data['senderEmail'] == chatService.currentUser!.email;

    // align the message based on the sender
    Alignment alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: ChatBubble(
        message: data['message'],
        isCurrentUser: isCurrentUser,
      ),
    );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, left: 10, right: 10),
      child: Row(
        children: [
          // text field for user to type message
          Expanded(
              child: MyUserInput(
            hintText: "Aa...",
            obscureText: false,
            controller: _messageController,
            onAttachPressed: pickAndSendImage,
          )),

          SizedBox(
            width: 10,
          ),
          // send button
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30),
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                size: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
