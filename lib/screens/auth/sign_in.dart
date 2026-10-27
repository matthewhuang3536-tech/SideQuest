import 'package:flutter/material.dart';
import 'package:quest/services/auth.dart';
import 'package:quest/shared/constants.dart';
class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn ({required this.toggleView });

  @override
  _SignInState createState() => _SignInState();
} 

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Login"),
        actions:<Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text("Register"),
            onPressed : () {
              widget.toggleView();
            }
          )
        ]
      ),
      body:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal:50),
          child:Form(
            key:_formKey,
            child: Column(
              children: [
                SizedBox(height:20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText:"Email"),
                  validator: (val) => val!.isEmpty ? "enter an email" : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  }
                ),
                SizedBox(height:20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText:"Password"),
                  obscureText: true,
                  validator: (val) => val!.length < 6 ? "pass must be 6+ chars" : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  }
                ),
                SizedBox(height:20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                    ),
                  child: Text("Sign in",
                  style: TextStyle(color:Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                        if(result == null) {
                          setState(() => error = "wrong email/password");
                      }
                    }
                  },
                  ),
                  SizedBox(height:12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize:14)),
                ]
              )
          )
        ),
      )
    );
  }
}