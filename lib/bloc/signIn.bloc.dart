import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInBloc {
  static FirebaseAuth auth = FirebaseAuth.instance;

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

  static Future<int> signIn(
      {@required String email, @required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
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
