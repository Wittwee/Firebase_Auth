// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_try/screens/profile.dart';
import 'package:firebase_try/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_try/services/authentication.dart';


class Signup extends StatefulWidget {
  const Signup({Key? key,}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {


  bool? rememberMe = false;
  bool showErrorMessage = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();
  final Authentication _authentication = Authentication();

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: Text("Create your account"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back,),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: ListView(shrinkWrap: true,
        children:[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Center(
                    child: Row(mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          boxShadow: [BoxShadow(blurRadius: 20, offset: Offset(5, 5)),
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
                  Center(child: Text("HAPPY TO SEE YOU!",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.deepPurpleAccent,
                        fontSize: 30),)),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: _firstNameController,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(border: InputBorder.none,
                            hintText: "First Name",
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
                      ),
                      SizedBox(width: 20.0,),
                      Expanded(child: TextField(
                        controller: _lastNameController,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(border: InputBorder.none,
                          hintText: "Last Name",
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular((12))
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurpleAccent),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    controller: _emailController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(border: InputBorder.none,
                      hintText: "Email",
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
                  SizedBox(height: 20,),
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
                  SizedBox(height: 20,),
                  TextField(
                    obscureText: true,
                    controller: _passwordConfirmationController,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(border: InputBorder.none,
                      hintText: "Confirm Password",
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
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                activeColor: Colors.deepPurpleAccent,
                value: rememberMe,
                onChanged: _checkPressed,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),

              ),
              Text("I have read and agree with the Terms of Service. ")
            ],),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(12)),),
              onPressed: _signUpPressed,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text("Sign Up",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold),),
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Already have an account?'),
              TextButton(onPressed: () => {Navigator.pop(
                context, MaterialPageRoute(
                builder: (context) => Login(),),),
              },
                child: Text("Login",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],),
        ],
      ),
    );
  }

  void _signUpPressed() async {

    if (_formKey.currentState!.validate()){
      if(_passwordController.text.trim().length < 6 || _passwordConfirmationController.text.trim().length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.deepPurpleAccent,
            content: Row(mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(Icons.warning, color: Colors.white,),
                SizedBox(width: 5,),
                Text("Password is too short!",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        );
      }else if(_passwordController.text.trim() != _passwordConfirmationController.text.trim()){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.deepPurpleAccent,
            content: Row(mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(Icons.warning, color: Colors.white,),
                SizedBox(width: 5,),
                Text("Passwords don't match!",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ],
            ),
          ),
        );
      }
      else if(rememberMe != true){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.deepPurpleAccent,
            content: Row(
              children: [
                Icon(Icons.warning, color: Colors.white,),
                SizedBox(width: 5,),
                Expanded(
                  child: Text("You must accept before continuing.",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        setState(() => showErrorMessage = false);
      }
    }

    if (rememberMe==null || !rememberMe!) {
      print("User has to accept first");
      return;
    }

    await _authentication.signUp(_emailController.text.trim(),
      _passwordController.text.trim(),).then((wasSuccessful) {
      addUserDetails(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _emailController.text.trim(),
      );

      wasSuccessful? Navigator.push(context, MaterialPageRoute(builder:
          (context) => Profile(),)) : print("Error");
    }
    );
  }

  Future addUserDetails(String firstName, String lastName, String email,) async {
    print("rememberMe==null: ${rememberMe==null}, $rememberMe: !rememberMe!");


    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'email': email,
    });
  }

  void _checkPressed(value) {
    setState(() {
      rememberMe = value;
    });
  }
}

