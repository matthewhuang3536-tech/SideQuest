import "package:flutter/material.dart";
import 'package:camera/camera.dart';
import 'package:quest/shared/constants.dart';
import 'package:quest/services/camera.dart';
import 'package:quest/screens/home/post.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final UseCamera camera = UseCamera();
  @override
  void initState() {
    super.initState();
    camera.initialize().then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    camera.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = camera.controller;

    if (controller == null || !controller.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        title :Text("take a photo!")
      ),
      body: Column(
        children: [
          CameraPreview(controller),
          SizedBox(height:30),
          Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.large(
              child: const Icon(Icons.flip_camera_ios),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                color: Colors.white,
                width:4
                )
              ),
              onPressed: () async {
                await camera.switchCamera();

                if (mounted) {
                  setState(() {});
                }
              },
            ),
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
                XFile? picture = await camera.takePicture();

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
