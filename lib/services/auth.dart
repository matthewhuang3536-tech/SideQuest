import 'package:firebase_auth/firebase_auth.dart' as firebase;
import "package:quest/models/user.dart";
import 'package:quest/services/userdatabase.dart';

class AuthService {
  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;
  // create user obj based on User
  AppUser? _userfromFirebaseUser(firebase.User? user) {
    return user != null ? AppUser(uid:user.uid) : null;
  }
  // auth change user stream
  Stream<AppUser?> get user {
    return _auth.authStateChanges()
    .map((firebase.User? user) => _userfromFirebaseUser(user)); 
  }
  //sign in anon
  Future signInAnon() async {
    try {
      firebase.UserCredential result = await _auth.signInAnonymously();
      firebase.User user = result.user!;
      return _userfromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
      
    }

  } 
    //sign in email/pass
   Future signInWithEmailAndPassword(String email, String password) async {
    try {
      firebase.UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebase.User? user = result.user;

    

      return _userfromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  //register email+pass
  Future registerWithEmailAndPassword(String email, String password, String username) async {
    try {
      firebase.UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebase.User? user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid : user!.uid).updateUserData(email, password, username);

      return _userfromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}