import "package:flutter/material.dart";
import 'package:quest/services/auth.dart';
import 'package:quest/shared/constants.dart';
class Register extends StatefulWidget {

  final Function toggleView;
  Register({required this.toggleView });


  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
  String username = "";
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign up"),
        actions:<Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign In"),
            onPressed : () {
              widget.toggleView();
            }
          )
        ]
      ),
      body:Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal:20),
        child:SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height:20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText:"Email"),
                  validator: (val) => val!.isEmpty ? "Enter an Email" : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  }
                ),
                SizedBox(height:20),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText:"Password"),
                  obscureText: true,
                  validator: (val) => val!.length < 6 ? "Enter a password 6+ chars long" : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  }
                ),
                SizedBox(height:20),
                              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText:"Username"),
                  onChanged: (val) {
                    setState(() => username = val); // deal with repeating usernames
                  },
                  validator: (val) => val!.length > 10? "Username must be less than 10 chars" : null,
                ),
                SizedBox(height:20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )
                    ),
                  child: Text("Register",
                  style: TextStyle(color:Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password, username);
                      if(result == null) {
                        setState(() => error = "please supply a valid email");
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
          ),
        )
      )
    );
  }
}