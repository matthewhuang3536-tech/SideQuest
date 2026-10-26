import "package:flutter/material.dart";
import 'package:camera/camera.dart';
import 'package:quest/services/camera.dart';
import 'package:quest/screens/home/post.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
//deal with this if you have time; not really necessary
class PostCombo extends StatefulWidget {

  @override
  State<PostCombo> createState() => _PostComboState();
}

class _PostComboState extends State<PostCombo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        title :Text("Complete your quest!")
      ),
      body: Column(
        children: [
          //addshit
          SizedBox(height:30),
          Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.large(
              child: const Icon(Icons.photo),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                color: Colors.white,
                width:4
                )
              ),
              onPressed: () async {

                if (mounted) {
                  setState(() {});
                }

                if (picture != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostScreen(picture: picture),
                    ),
                  );
                }
                ;
              },
            ),
          ],
        ),
      ),
        ],
      ),


    );
  }
}
