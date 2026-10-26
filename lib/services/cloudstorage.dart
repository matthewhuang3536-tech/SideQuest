import 'package:camera/camera.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Cloudstorage {
  Future<String> uploadPhoto(XFile picture) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('posts')
        .child(fileName);

    await storageRef.putFile(File(picture.path));

    String downloadUrl = await storageRef.getDownloadURL();

    return downloadUrl;
  }
}
