import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({this.uid });

  //collection reference
  final CollectionReference userInfo = FirebaseFirestore.instance.collection("users");

  Future updateUserData(String email, String password, String username) async {
  DateTime dates = DateTime.now();
  String day = "${dates.month}-${dates.day}-${dates.year}";
    return await userInfo.doc(uid).set({
      "datecreated" : day,
      "username" : username,
      "email" : email,
      "password" : password,
      });
  }
  //stream of changes
  Stream<QuerySnapshot> get users {
    return userInfo.snapshots();
  }


}