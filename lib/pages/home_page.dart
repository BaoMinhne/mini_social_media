import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_media/components/my_drawer.dart';
import 'package:mini_social_media/components/my_post.dart';
import 'package:mini_social_media/components/my_post_button.dart';
import 'package:mini_social_media/components/my_textfield.dart';
import 'package:mini_social_media/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  // get current user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // controller
  TextEditingController newPostController = TextEditingController();
  void postMessage() {
    // only post if there is something in the textfield
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }

    // clear the controller
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "W A L L",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          // Textfield box for user to type
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: MyTextfield(
                      hintText: "Say something...",
                      obscureText: false,
                      controller: newPostController),
                ),
                MyPostButton(onTap: postMessage),
              ],
            ),
          ),

          // Posts
          StreamBuilder(
            stream: database.getPostStream(),
            builder: (context, snapshot) {
              // show loading
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // get all post
              final posts = snapshot.data!.docs;

              // no data?
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Text("No posts...Post Something!!"),
                  ),
                );
              }

              // return a list
              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    final data = post.data() as Map<String, dynamic>;

                    String message = data['PostMessage'];
                    Timestamp timestamp = data['TimeStamp'];
                    String email = data['UserEmail'];
                    List likes = data['Likes'] ?? [];

                    String displayEmail =
                        currentUser!.email == email ? "You" : email;

                    return MyPost(
                      message: message,
                      userEmail: displayEmail,
                      time: timestamp,
                      likes: likes,
                      postId: post.id,
                      onLikePressed: () {
                        FirestoreDatabase().toggleLike(post.id);
                      },
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
