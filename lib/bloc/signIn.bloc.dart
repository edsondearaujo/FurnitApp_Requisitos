import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furnitapp/LoggedUser.dart';
import 'package:furnitapp/models/user.dart';

class SignInBloc {
  static FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  static String validateEmail(String email) {
    bool hasMach = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email.toString());
    if (hasMach) {
      return null;
    } else {
      return 'Entre com um email válido';
    }
  }

  static String validatePassword(String password) {
    bool isOk = password.length > 6;
    if (isOk) {
      return null;
    } else {
      return 'Senha muito pequena';
    }
  }

  Future<int> signIn(
      {@required String email, @required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      DocumentSnapshot userDoc = await firestore
          .collection('users')
          .doc(userCredential.user.uid)
          .get();

      LoggedUser.fuser = Fuser.fromDocument(userDoc);
      LoggedUser.user = userCredential.user;

      return 1;
    } catch (error) {
      if (error == 'user-not-found') {
        return 2;
        //send user to signUp
      } else if (error == 'wrong-password') {
        //send Error
        return 3;
      } else {
        //Unknow error
        return 4;
      }
    }
  }
}
