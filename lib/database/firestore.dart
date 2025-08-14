/*

This database stores posts that users have published in the app
It is stored in a collection called "Posts" in Firebase

Each post contains: 
 - a message 
 - a email of user
 - timestamp

 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  // current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  // get collection of posts from database
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("Posts");

  // post a message
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'TimeStamp': Timestamp.now(),
      'Likes': [],
    });
  }

  // read posts from database
  Stream<QuerySnapshot> getPostStream() {
    final postsStream = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("TimeStamp", descending: true)
        .snapshots();

    return postsStream;
  }

  // get comments for a specific post
  Stream<QuerySnapshot> getCommentStream(String postId) {
    final comments = FirebaseFirestore.instance
        .collection("Posts")
        .doc(postId)
        .collection("Comments")
        .orderBy("TimeStamp", descending: false)
        .snapshots();

    return comments;
  }

// toggle like for a post
  Future<void> toggleLike(String postId) async {
    final postRef = posts.doc(postId);
    final snapshot = await postRef.get();

    List likes = List.from(snapshot['Likes'] ?? []);
    final currentUserEmail = user!.email;

    if (likes.contains(currentUserEmail)) {
      likes.remove(currentUserEmail);
    } else {
      likes.add(currentUserEmail);
    }

    await postRef.update({'Likes': likes});
  }

  // add a comment to a post
  Future<void> addComment(String postId, String commentText) async {
    final comment = {
      'CommentText': commentText,
      'CommenterEmail': user!.email,
      'TimeStamp': Timestamp.now(),
    };

    await posts.doc(postId).collection('Comments').add(comment);
  }
}
