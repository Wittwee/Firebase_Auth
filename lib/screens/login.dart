// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_try/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_try/global_colors.dart';
import 'package:firebase_try/services/authentication.dart';
import 'package:firebase_try/screens/signup_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key,}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // String? email = FirebaseAuth.instance.currentUser?.email;

  // final TextEditingController _lastNameController = TextEditingController();
  // final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _userSignedIn = false;
  final Authentication _authentication = Authentication();

  @override
  void initState() {
    super.initState();

    /// Events are fired when the following occurs:
    /// - Right after the listener has been registered.
    /// - When a user is signed in.
    /// - When the current user is signed out.
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() => _userSignedIn = false);
      } else {
        print('User is signed in!');
        setState(() => _userSignedIn = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: Text("Log In"),
        // backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back,),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50,),
            Center(
              child: Row(mainAxisSize: MainAxisSize.min,
                children: [
                  Container(decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(90),
                    boxShadow: [BoxShadow(blurRadius: 20, offset: Offset(-5, 5)),
                    ],
                  ),
                      child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.deepPurpleAccent,
                          child: Center(
                              child: Icon(
                                Icons.apple,
                                size: 100,
                                color: Colors.white,
                              )
                          )
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Center(child: Text("WELCOME BACK", style: TextStyle(fontWeight: FontWeight.w800, color: Colors.deepPurpleAccent, fontSize: 30),)),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(border: InputBorder.none,
                      hintText: "Phone number, username or email",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular((12))
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                  SizedBox(height: 10,), //spacing
                  TextField(
                    obscureText: true,
                    controller: _passwordController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(border: InputBorder.none,
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular((12))
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      fillColor: Colors.white,
                      filled: true,

                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25,),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent, shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(12)),),
                onPressed: _logInPressed,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("Login", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\'t have an account?', style: TextStyle(fontSize: 15),),
                TextButton(onPressed: () => {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Signup(),),),
                },
                    child: Text("Register", style: TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold),))
              ],),
          ],
        ),
      ),
    );
  }


  void _logInPressed() async {
    _authentication.signIn(_emailController.text.trim(),
      _passwordController.text.trim(),).then((wasSuccessful) =>
    wasSuccessful ? (Navigator.push(
      context, MaterialPageRoute(builder: (context) => Profile(),),)).then((value) => FirebaseFirestore.instance.collection('UserData').doc(FirebaseAuth.instance.currentUser?.uid).set({"email": _userSignedIn})) : print("Error")
    );
  }

}


