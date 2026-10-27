import "package:flutter/material.dart";
import 'package:camera/camera.dart';
import 'package:quest/shared/constants.dart';
import 'package:quest/services/camera.dart';
import 'package:quest/services/cloudstorage.dart';
import 'package:quest/models/user.dart';
import 'package:quest/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:quest/services/updatepfp.dart';

class ProfilePic extends StatefulWidget {

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final UseCamera camera = UseCamera();

  bool loading = false;
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
    final user = context.watch<AppUser?>();
    if (loading) {
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
                  setState(() {
                  loading = true;
                  },
                  );
                XFile? picture = await camera.takePicture();

                if (mounted) {
                  setState(() {});
                }

                if (picture != null){
                  try {
                  Cloudstorage cloudstorage = Cloudstorage();
                  String imageUrl = await cloudstorage.uploadPhoto(
                    picture,
                  );
                  ProfileUpdate(uid:user!.uid).updatePFP(imageUrl);}
                  catch (e) {
                    print("Error uploading photo: $e");
                  }
                  loading = false;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Wrapper(),
                    ),
                    (route) => false,
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
