import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:quest/screens/connect/connect.dart';
import "package:quest/screens/home/feed.dart";
import 'package:quest/screens/tasks/task_list.dart';
import "package:quest/screens/auth/authenticate.dart";
import "package:quest/models/user.dart";
import 'package:quest/screens/profile/profile.dart';
import "package:quest/shared/constants.dart";

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
    int screen_num = 0;
  @override
  Widget build(BuildContext context) {

  final List<Widget> screens = [
    Feed(),
    Quests(),
    Connections(),
    Profile()
  ];
    final user = Provider.of<AppUser?>(context);

//return home or auth widget based on login
    if (user == null) {
      return Authenticate();
    } else {
      print('Current screen: $screen_num');
      return Scaffold(
      body: screens[screen_num],

      bottomNavigationBar: NavigationBar(
        backgroundColor: skyblue,
        selectedIndex: screen_num,
        onDestinationSelected: (index) {
          setState(() {
            screen_num = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: 'Quests',
          ),
                    NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Archive',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
    }

  }
}