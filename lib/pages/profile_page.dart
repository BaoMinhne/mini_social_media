import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_social_media/components/my_user_tile.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // future to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "P R O F I L E",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          // loading..
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // error
          else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          // data
          else if (snapshot.hasData) {
            // extract data
            Map<String, dynamic>? user = snapshot.data!.data();
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // profile pic
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: EdgeInsets.all(25),
                    child: Icon(
                      Icons.person,
                      size: 64,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Text(
                      "Hello, ${user!['username']}!",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "\"Be yourself - that's the best thing!!\"",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  // username and email
                  MyUserTile(title: "Username", value: user['username']),
                  MyUserTile(title: "Email", value: user['email']),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            );
          } else {
            return Text('No Data Found');
          }
        },
      ),
    );
  }
}
