import 'package:flutter/material.dart';
import 'package:quest/screens/home/camerascreen.dart';
import "package:quest/services/userdatabase.dart";
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quest/services/quest.dart';
import 'package:quest/global.dart';
import 'package:quest/shared/constants.dart';

class Quests extends StatefulWidget {
  @override
  State<Quests> createState() => _QuestsState();
}

class _QuestsState extends State<Quests> {
  dynamic dayquest = getTaskDaily();
  dynamic weekquest = getTaskWeekly();
  dynamic monthquest = getTaskMonthly();
  List<Widget> quests_todo = [];
  @override
  Widget build(BuildContext context) {
    List<dynamic> quests = [
      Card(
        color:blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(dayquest["title"]),
              Text(dayquest["description"]),
              ElevatedButton(
                child: Text("Complete!"),
                onPressed: () {
                  quest = 0;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Post()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      Card(
        color:white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(weekquest["title"]),
              Text(weekquest["description"]),
              ElevatedButton(
                child: Text("Complete!"),
                onPressed: () {
                  quest = 1;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Post()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      Card(
        color:red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(monthquest["title"]),
              Text(monthquest["description"]),
              ElevatedButton(
                child: Text("Complete!"),
                onPressed: () {
                  quest = 2;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Post()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ];
    for (int num = 0; num < 3; num++) {
      if (quests_done[num]) {
      } else {
        quests_todo.add(quests[num]);
      }

      if (quests_todo.isEmpty) {
        quests_todo.add(
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("All Finished!")],
            ),
          ),
        );
      }
    }
    return StreamProvider<QuerySnapshot?>.value(
      value: DatabaseService().users,
      initialData: null,
      child: Scaffold(
        backgroundColor: yellow,
        appBar: AppBar(
          backgroundColor: teal,
          title: const Text('Quests'),
        ),
        body: SingleChildScrollView(child: Column(children: quests_todo)),
      ),
    );
  }
}
