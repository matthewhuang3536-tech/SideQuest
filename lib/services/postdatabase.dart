import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quest/services/quest.dart';
import 'package:quest/global.dart';
class PostsService {

  final String url;
  final String caption;
  final String uid;
  final String? username;
  final String pfp;
  PostsService({ 
    required this.url,
    required this.caption,
    required this.uid,
    required this.pfp,
    this.username,
  });

  //collection reference
  final CollectionReference postInfo = FirebaseFirestore.instance.collection("posts");
  final CollectionReference userInfo = FirebaseFirestore.instance.collection("users");






  Future newPost() async {
  List<Function> quests = [getTaskDaily,getTaskWeekly,getTaskMonthly];
  Function quest_name = quests[quest];
  dynamic current_post = quest_name();
  FieldValue date = FieldValue.serverTimestamp();
  DateTime dates = DateTime.now();
  String day = "${dates.month}-${dates.day}-${dates.year}";
    quests_done[quest] = true;
    await FirebaseFirestore.instance.collection('posts').add({
      "uid" : uid,
      "username" : username,
      "datecreated" : date,
      "image" : url,
      "caption" : caption,
      "pfp" : pfp,
      });
    await FirebaseFirestore.instance.collection('users').doc(uid).collection("connections").add({
      "connections" : caption.split("@").sublist(1),
      "quest_name" : current_post["title"],
      "date created" : date,
      "format_time" : day
      });
  }
  //stream of changes
  Stream<QuerySnapshot> get posts {
    return postInfo.snapshots();
  }


}