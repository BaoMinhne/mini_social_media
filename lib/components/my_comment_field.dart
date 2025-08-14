import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class MyCommentField extends StatelessWidget {
  final String userEmail;
  final String commentText;
  final Timestamp time;

  const MyCommentField({
    super.key,
    required this.userEmail,
    required this.commentText,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          const CircleAvatar(
            backgroundImage: AssetImage(
                'assets/images/user.png'), // hoặc NetworkImage nếu có ảnh thật
            radius: 20,
          ),
          const SizedBox(width: 10),

          // Nội dung bình luận
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tên + thời gian
                  Row(
                    children: [
                      Text(
                        userEmail,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        DateFormat('HH:mm').format(time.toDate()),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Nội dung
                  Text(
                    commentText,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
