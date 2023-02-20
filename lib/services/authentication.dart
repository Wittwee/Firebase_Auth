// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {

  /// checks whether email looks something like "name@mail.com"
  bool emailConforms(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.trim());
  }

  Future<bool> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = FirebaseAuth.instance.currentUser;
      print("_signUp() - user: $user");

      /// OPTIONAL - send email verification
      if (user!=null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("Password is too weak");
      } else if (e.code == 'email-already-in-use') {
        print("An account already exists for that email.");
      } else {
        print(e.message);
      }
    } catch (e) {
      print(e);
    }
    return false;
  }


  Future<bool> signIn(String email, String password) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      print(user);

      if (user == null) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }

      /// OPTIONAL - email verification check
      // reload user, because even if user verified, it still might show that it is not verified
      await user?.reload();
      user = FirebaseAuth.instance.currentUser;
      if (user!=null && !user.emailVerified) {
        print("user hasn't verified email");
        return false;
      } else {
        print("user HAS verified email & is signed in");
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        print("Wrong password provided for that user.");
      } else {
        print("An error occurred: \"${e.message}\"");
      }
    } catch (e) {
      print(e);
    }
    return false;
  }



  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> isEmailVerified() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    } else {
      // reload user, because even if user verified, it still might show that it is not verified
      await user.reload();
      user = FirebaseAuth.instance.currentUser;
      return user!.emailVerified;
    }
  }

}

