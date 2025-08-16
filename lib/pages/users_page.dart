import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_media/components/my_user_field.dart';
import 'package:mini_social_media/helper/helper_function.dart';
import 'package:mini_social_media/pages/chat_page.dart';
import 'package:mini_social_media/services/chat/chat_service.dart';

class UsersPage extends StatelessWidget {
  UsersPage({super.key});

  final ChatService _chatService = ChatService();
  // get current user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "U S E R S",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          // any errors
          if (snapshot.hasError) {
            displayMessageToUser("Some Thing Went Wrong", context);
          }

          // show loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null) {
            return Text('No Data Found');
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>(
                  (userData) => _buildUserListItem(userData, context),
                )
                .toList(),
          );
        },
      ),
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all users except the current user
    if (userData["email"] != currentUser!.email) {
      return MyUserField(
          userMail: userData["email"],
          userName: userData["username"],
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                      reciverEmail: userData["email"],
                      reciverName: userData["username"]),
                ));
          });
    } else {
      return const SizedBox
          .shrink(); // Return an empty widget for the current user
    }
  }
}
