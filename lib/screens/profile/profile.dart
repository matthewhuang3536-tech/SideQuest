import 'package:flutter/material.dart';
import 'package:quest/shared/constants.dart';
import 'package:quest/screens/home/camerascreen.dart';
import 'package:quest/services/auth.dart';
import "package:quest/services/userdatabase.dart";
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quest/services/username.dart';
import "package:quest/models/user.dart";

class Profile extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppUser?>();
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get(),
      builder: (context, asyncSnapshot) {
        final user_doc = asyncSnapshot.data!;       
        final user_info = user_doc.data()!; 
        return Scaffold(
          appBar: AppBar(
            backgroundColor: blue,
            title: const Text('Profile'),
          ),
          body:Column(
            children: [
              Row(
                children: [
                  FloatingActionButton(
                    onPressed: null),
                  Column(
                    children: [
                      Text(user_info["username"]),
                      Text("${user_info["date created"]}")
                    ],)
                ],
              ),
              SizedBox(),
              Text(user_info["email"]),
              SizedBox(),
              Text(user_info["password"]),
              FloatingActionButton(
                  child: Text("logout"),
                  onPressed: () async {
                    await _auth.signOut();
                  }
              ),

            ],
          )
        );
      }
    );
  }
}

