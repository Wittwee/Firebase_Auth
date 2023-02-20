// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_try/global_colors.dart';
import 'package:firebase_try/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);



  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final CollectionReference _referenceUsers = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    // _referenceUsers.snapshots();
    return Scaffold(backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {},
            icon: Icon(Icons.edit, color: Colors.white, size: 30),),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(onPressed: () {},
              icon: Icon(Icons.settings, color: Colors.white, size: 30,),),
          ),
        ],
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: Text("Profile"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(shape: BoxShape.circle,
                    color: Colors.black,
                    image: DecorationImage(
                      image: AssetImage('images/tate_pfp.JPG'),),),),
                SizedBox(width: 10,),
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: "Description",
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.deepPurpleAccent),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("First Name", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),),
                )),
            SizedBox(height: 5,),
            Container(width: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all(color: Colors.deepPurpleAccent)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15, horizontal: 10),
                child: Text('',
                  style: TextStyle(fontSize: 20, color: Colors.grey),),
              ),),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.deepPurpleAccent),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("First Name", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),),
                )),
            SizedBox(height: 5,),
            Container(width: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  border: Border.all(color: Colors.deepPurpleAccent)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15, horizontal: 10),
                child: Text(emailAddress(),
                  style: TextStyle(fontSize: 20, color: Colors.grey),),
              ),),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text('User:', style: TextStyle(
                        fontSize: 23, decoration: TextDecoration.underline,),),
                    )),
                SizedBox(height: 10,),
                Text(emailAddress(), style: TextStyle(fontSize: 20),),

              ],
            ),
            SizedBox(height: 20,),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(color: Colors.grey[300],
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text('ID:', style: TextStyle(
                        fontSize: 23, decoration: TextDecoration.underline,),),
                    )),
                SizedBox(height: 10,),
                Text(userId(), style: TextStyle(fontSize: 20),),

              ],
            )

          ],),
      ),
    );
  }
    String emailAddress() {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return 'No user found';
      } else {
        user = FirebaseAuth.instance.currentUser;
        return user?.email ?? "Error";
      }
    }
    // String firstName() {
    //   User? user = FirebaseAuth.instance.currentUser;
    //
    //   if (user == null) {
    //     return 'No user found';
    //   } else {
    //     user = FirebaseFirestore.instance.collection('users').id as User?;
    //     return user?.email ?? "Error";
    // }
    // }

    String userId() {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        return 'No user found';
      } else {
        user = FirebaseAuth.instance.currentUser;
        return user?.uid ?? "Error";
      }
    }
  }
