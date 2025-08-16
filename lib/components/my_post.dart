import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_social_media/pages/comments_page.dart';

class MyPost extends StatelessWidget {
  final String message;
  final String userEmail;
  final Timestamp time;
  final List likes;
  final String postId;
  final VoidCallback onLikePressed;

  const MyPost({
    super.key,
    required this.message,
    required this.userEmail,
    required this.time,
    required this.likes,
    required this.postId,
    required this.onLikePressed,
  });

  @override
  Widget build(BuildContext context) {
    final currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
    final bool isLiked = likes.contains(currentUserEmail);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 15, left: 15, right: 15),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userEmail,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        DateFormat('dd-MM-yyyy HH:mm').format((time).toDate()),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.more_vert, color: Colors.grey, size: 30),
                ],
              ),
            ),

            // Post message
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),
            ),

            // Action bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onLikePressed,
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.grey,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${likes.length}',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.comment_outlined,
                        color: Colors.grey, size: 30),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CommentPage(postId: postId),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.send_outlined, color: Colors.grey, size: 30),
                  const Spacer(),
                  const Icon(Icons.bookmark_border,
                      color: Colors.grey, size: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
