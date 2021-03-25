import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpBloc {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();

  static Future<bool> signup({@required String email, @required password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (error) {
      print(error);
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
