import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../database/firestore.dart';

class CommentPage extends StatefulWidget {
  final String postId;

  const CommentPage({super.key, required this.postId});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController commentController = TextEditingController();
  final FirestoreDatabase database = FirestoreDatabase();

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
              stream: FirebaseFirestore.instance
                  .collection("Posts")
                  .doc(widget.postId)
                  .collection("Comments")
                  .orderBy("TimeStamp", descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final comments = snapshot.data!.docs;

                if (comments.isEmpty) {
                  return const Center(child: Text("No comments yet..."));
                }

                return ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final data = comments[index].data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(
                        data['CommenterEmail'] ?? '',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        data['CommentText'] ?? '',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      trailing: Text(
                        (data['TimeStamp'] as Timestamp)
                            .toDate()
                            .toString()
                            .substring(0, 16),
                        style: const TextStyle(fontSize: 12),
                      ),
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
                  child: TextField(
                    controller: commentController,
                    decoration: const InputDecoration(
                      hintText: "Add a comment...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
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
