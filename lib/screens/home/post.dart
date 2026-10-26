import 'package:quest/screens/wrapper.dart';
import 'package:quest/services/cloudstorage.dart';
import 'package:flutter/material.dart';
import 'package:quest/screens/home/feed.dart';
import 'package:provider/provider.dart';

import "package:quest/models/user.dart";
import 'package:camera/camera.dart';
import 'package:quest/services/postdatabase.dart';
import 'dart:io';
import 'package:quest/services/username.dart';
import 'package:quest/shared/constants.dart';

class PostScreen extends StatefulWidget {
  final XFile picture;
  const PostScreen({super.key, required this.picture});
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String caption = "";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppUser?>();
    if (loading) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
      backgroundColor: blue),
      body: Center(
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [CircularProgressIndicator(), Text("Loading!")]
        ),
      ),
    );
  }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(File(widget.picture!.path)),
            SizedBox(height: 20),
            TextFormField(
              decoration: textInputDecoration.copyWith(
                hintText: "Describe your experience!",
              ),
              onChanged: (val) {
                setState(() => caption = val);
              },
            ),
            SizedBox(height:20),
            //add loading screen after press
            FloatingActionButton(
              onPressed: () async {
                  setState(() {
                  loading = true;
                  },
                  );
                try {
                  Cloudstorage cloudstorage = Cloudstorage();
                  String imageUrl = await cloudstorage.uploadPhoto(
                    widget.picture,
                  );
                  final username = await getUsername();
                  PostsService(
                    url: imageUrl,
                    caption: caption,
                    uid: user!.uid,
                    username: username,
                  ).newPost();
      
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Wrapper()),
                    (Route<dynamic> route) => false,
                  );
                  loading = false;
                  
                } catch (e) {
                  print('Upload failed: $e');
                }
              },
      
              child: Icon(Icons.upload),
            ),
          ],
        ),
      ),
    );
  }
}
