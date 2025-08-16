import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mini_social_media/models/message.dart';

class ChatService {
  // get instance of Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('Users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        // go through each document and convert to Map
        final user = doc.data();

        // return user
        return user;
      }).toList();
    });
  }

  // send message
  Future<void> sendMessage(String receiverEmail, String message) async {
    // get current user info
    final String currentUserEmail = currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
      message: message,
      senderEmail: currentUserEmail,
      receiverEmail: receiverEmail,
      timestamp: timestamp,
    );

    // construct the chat room ID for the two users
    List<String> ids = [currentUserEmail, receiverEmail];
    ids.sort(); // sort to ensure consistent chat room ID
    String chatRoomId = ids.join('_');

    // add new message to the chat room
    await _firestore
        .collection('ChatRooms')
        .doc(chatRoomId)
        .collection('Messages')
        .add(newMessage.toMap());
  }

  // get messages stream
  Stream<QuerySnapshot> getMessages(String userEmail, otherEmail) {
    // construct the chat room ID for the two users
    List<String> ids = [userEmail, otherEmail];
    ids.sort(); // sort to ensure consistent chat room ID
    String chatRoomId = ids.join('_');

    // return the messages stream
    return _firestore
        .collection('ChatRooms')
        .doc(chatRoomId)
        .collection('Messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
