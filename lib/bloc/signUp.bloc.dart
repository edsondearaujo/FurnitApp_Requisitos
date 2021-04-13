import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furnitapp/LoggedUser.dart';
import 'package:furnitapp/models/user.dart';

class SignUpBloc {
  static FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  Future<bool> createUserDocument(
      {@required Fuser fuser, @required User user}) async {
    try {
      await firestore.collection('users').doc(user.uid).set(
          {'isAdmin': fuser.isAdmin, 'email': fuser.email, 'id': user.uid});

      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> signup({@required String email, @required password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      Fuser fuser =
          Fuser(email: email, isAdmin: false, id: userCredential.user.uid);
      await createUserDocument(fuser: fuser, user: userCredential.user);

      DocumentSnapshot documentSnapshot = await firestore
          .collection('users')
          .doc(userCredential.user.uid)
          .get();

      LoggedUser.fuser = Fuser.fromDocument(documentSnapshot);
      LoggedUser.user = userCredential.user;

      return true;
    } catch (error) {
      return false;
    }
  }

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
}
