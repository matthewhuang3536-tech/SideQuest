import 'package:flutter/material.dart';
import 'package:quest/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quest/services/auth.dart';
import 'firebase_options.dart';
import "package:provider/provider.dart";
import "package:quest/models/user.dart";
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DateTime now = DateTime.now();
  int dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays + 1;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );  
  }
}

