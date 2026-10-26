import 'package:flutter/material.dart';
import 'package:quest/shared/constants.dart';
import 'package:quest/screens/home/camerascreen.dart';
import "package:quest/services/userdatabase.dart";
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService().users,
      initialData: null,
      child: Scaffold(
        backgroundColor: red,
        appBar: AppBar(
          backgroundColor: green,
          title: const Text('For You'),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .orderBy('datecreated', descending: true)
                    .snapshots(),

                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final posts = snapshot.data!.docs;
                  print('Number of posts: ${posts.length}');

                  if (posts.isEmpty) {
                    return const Center(child: Text('No posts yet!'));
                  }

                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index].data();

                      return Card(
                        color:realpink,
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              leading: const CircleAvatar(
                                child: Icon(
                                  Icons.person,
                                ), // choose to add profile pics or remove this
                              ),
                              title: Text(post['username'] ?? 'User'),
                            ),

                            Image.network(
                              post['image'] ?? '',
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                print(post['image']);
                                return const SizedBox(
                                  height: 200, // cutting image issue
                                  child: Center(
                                    child: Text('Could not load image'),
                                  ),
                                );
                              },
                            ),

                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(post['caption'] ?? ''),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
