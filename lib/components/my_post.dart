import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyPost extends StatelessWidget {
  final String message;
  final String userEmail;
  final Timestamp time;

  const MyPost(
      {super.key,
      required this.message,
      required this.userEmail,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // 💡 Màu nền post
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with avatar + email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                children: [
                  // Avatar
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
                  // User email
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
                        DateFormat('dd-MM-yyyy HH:mm')
                            .format((time as Timestamp).toDate()),
                        style: const TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                    size: 30,
                  ),
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
                children: const [
                  Icon(
                    Icons.favorite_border,
                    color: Colors.grey,
                    size: 30,
                  ),
                  SizedBox(width: 16),
                  Icon(
                    Icons.comment_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                  SizedBox(width: 16),
                  Icon(
                    Icons.send_outlined,
                    color: Colors.grey,
                    size: 30,
                  ),
                  Spacer(),
                  Icon(
                    Icons.bookmark_border,
                    color: Colors.grey,
                    size: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
