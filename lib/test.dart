// // ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_try/global_colors.dart';
// import 'package:firebase_try/services/authentication.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Test extends StatefulWidget {
//   const Test({Key? key}) : super(key: key);
//
//   @override
//   State<Test> createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//   final CollectionReference _referenceUsers = FirebaseFirestore.instance.collection('users');
//   late Stream<QuerySnapshot> _streamUserIds;
//   final QueryDocumentSnapshot<Object?> document;
//
//   @override
//   Widget build(BuildContext context) {
//     _streamUserIds = _referenceUsers.snapshots();
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _streamUserIds,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasError) {
//             return Center(child: Text(snapshot.error.toString()));
//           }
//           if (snapshot.connectionState == ConnectionState.active) {
//             QuerySnapshot querySnapshot = snapshot.data;
//             List<QueryDocumentSnapshot> listQueryDocumentSnapshot = querySnapshot.docs;
//             QueryDocumentSnapshot document = listQueryDocumentSnapshot.first;
//             return UserItem(document: document);
//           }
//           return Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }
//
// class UserItem extends StatefulWidget {
//   const UserItem({
//     Key? key,
//     required this.document,
//   }) : super(key: key);
//
//   final QueryDocumentSnapshot<Object?> document;
//
//   @override
//   State<UserItem> createState() => _UserItemState();
// }
//
// class _UserItemState extends State<UserItem> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Text(widget.document['first name'],),
//       SizedBox(height: 10,),
//       Text(widget.document['last name'],),
//     ]
//     );
//     // ListTile(
//     //   onTap: () {
//     //     Navigator.of(context).push(MaterialPageRoute(
//     //         builder: (context) => ItemDetails(widget.document.id)));
//     //   },
//     //   title: Text(widget.document['first_name']),
//     //   subtitle: Text(widget.document['quantity']),
//     //   trailing: Checkbox(
//     //     onChanged: (value) {
//     //       setState(() {
//     //         _purchased = value ?? false;
//     //       });
//     //     },
//     //     value: _purchased,
//     //   ),
//     // );
//   }
// }
//
//
// // ListView.builder(
// //                 itemCount: listQueryDocumentSnapshot.length,
// //                 itemBuilder: (context, index) {
// //                   QueryDocumentSnapshot document =
// //                   listQueryDocumentSnapshot[index];
// //                   return UserItem(document: document);
// //                 });