import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_social_media/components/my_comment_field.dart';
import 'package:mini_social_media/components/my_textfield.dart';
import '../database/firestore.dart';

class CommentPage extends StatefulWidget {
  final String postId;

  const CommentPage({super.key, required this.postId});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController commentController = TextEditingController();
  // firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  // get current user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  void postComment() {
    if (commentController.text.trim().isNotEmpty) {
      database.addComment(widget.postId, commentController.text.trim());
      commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comments")),
      body: Column(
        children: [
          // Danh sách comment
          Expanded(
            child: StreamBuilder(
              stream: database.getCommentStream(widget.postId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final comments = snapshot.data!.docs;

                if (comments.isEmpty) {
                  return const Center(
                      child: Text(
                    "No comments yet...",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ));
                }

                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final data = comments[index].data() as Map<String, dynamic>;
                    String email = data['CommenterEmail'] ?? 'Unknown';
                    // Hiển thị "You" nếu email của người bình luận là email của người dùng hiện tại
                    String displayEmail =
                        currentUser!.email == email ? "You" : email;
                    return MyCommentField(
                      userEmail: displayEmail,
                      commentText: data['CommentText'] ?? '',
                      time: data['TimeStamp'] as Timestamp,
                    );
                  },
                );
              },
            ),
          ),

          // Ô nhập bình luận
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: MyTextfield(
                      hintText: "Add Your Comment...",
                      obscureText: false,
                      controller: commentController),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    size: 35,
                  ),
                  onPressed: postComment,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
