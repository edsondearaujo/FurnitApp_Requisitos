import 'package:flutter/material.dart';

class SignInBloc {


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

  static String validatePassword( String password) {
    bool isOk = password.length > 6;
    if (isOk) {
      return null;
    } else {
      return 'Senha muito pequena';
    }
  }


}
