import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String senderEmail;
  final String receiverEmail;
  final Timestamp timestamp;

  Message({
    required this.message,
    required this.senderEmail,
    required this.receiverEmail,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'senderEmail': senderEmail,
      'receiverEmail': receiverEmail,
      'timestamp': timestamp,
    };
  }
}
