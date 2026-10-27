import 'package:flutter/material.dart';
import 'package:quest/shared/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:quest/services/auth.dart';
import 'package:quest/screens/profile/profilepic.dart';
import 'package:quest/global.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:quest/models/user.dart";

class Profile extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppUser?>();
    return FutureBuilder(
      future: Future.wait([
        FirebaseFirestore.instance
            .collection('posts')
            .where("uid", isEqualTo: user!.uid)
            .get(),

        FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
      ]),
      builder: (context, asyncSnapshot) {
        if (!asyncSnapshot.hasData) {
          return Scaffold(
            appBar: AppBar(backgroundColor: blue, title: const Text('Profile')),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [const CircularProgressIndicator()],
              ),
            ),
          );
        }
        final user_posts =
            asyncSnapshot.data![0] as QuerySnapshot<Map<String, dynamic>>;
        final post_info = user_posts.docs;
        final user_doc =
            asyncSnapshot.data![1] as DocumentSnapshot<Map<String, dynamic>>;
        final user_info = user_doc.data()!;
        return Scaffold(
          appBar: AppBar(backgroundColor: blue, title: const Text('Profile')),
          body: Padding(
            padding: EdgeInsets.all(26),
            child: Column(
              children: [
                Row(
                  children: [
                    FloatingActionButton.large(
                      onPressed: () {
                        quest = 4;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePic()),
                        );
                      },
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      child: ClipOval(
                        child: Image.network(
                          user_info["pfp"],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Text(
                          user_info["username"],
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${user_info["datecreated"]}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    SizedBox(
                      height: 30,
                      width: double.infinity,
                      child: AutoSizeText(
                        "Email:",
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        minFontSize: 8,
                        maxFontSize: 40,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: double.infinity,
                      child: AutoSizeText(
                        user_info["email"],
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        minFontSize: 8,
                        maxFontSize: 200,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 30,
                      width: double.infinity,
                      child: AutoSizeText(
                        "Password:",
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        minFontSize: 8,
                        maxFontSize: 200,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: double.infinity,
                      child: AutoSizeText(
                        user_info["password"],
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        minFontSize: 8,
                        maxFontSize: 200,
                      ),
                    ),

                    SizedBox(height: 10),
                    SizedBox(
                      height: 30,
                      width: double.infinity,
                      child: AutoSizeText(
                        "Quests Completed:",
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        minFontSize: 8,
                        maxFontSize: 200,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: double.infinity,
                      child: AutoSizeText(
                        post_info.length.toString(),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        minFontSize: 8,
                        maxFontSize: 200,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                FloatingActionButton.extended(
                  backgroundColor: pink,
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  label: const Text("Log Out",
                      style: TextStyle(fontSize: 25)),
                  icon: const Icon(Icons.logout, size: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
