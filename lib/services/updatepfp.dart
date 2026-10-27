import 'package:cloud_firestore/cloud_firestore.dart';
class ProfileUpdate {
  final String uid;
  ProfileUpdate({required this.uid });

  //collection reference

 final CollectionReference userInfo = FirebaseFirestore.instance.collection("users");
  Future updatePFP(String url) async {
    return await userInfo.doc(uid).update({
      "pfp" : url
      });
  }
  //stream of changes
  Stream<QuerySnapshot> get users {
    return userInfo.snapshots();
  }}