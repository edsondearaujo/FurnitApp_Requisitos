import 'package:flutter/material.dart';
import 'package:furnitapp/bloc/signIn.bloc.dart';
import 'package:furnitapp/constants.dart';
import 'package:furnitapp/page/home_page.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: 300,
        height: 70,
        decoration: BoxDecoration(
            color: kSecondaryColor, borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () async {
            bool isOk = await SignInBloc.signup(
                email: SignInBloc.emailController.text,
                password: SignInBloc.passwordController.text);
            if (isOk) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            }
          },
          child: Center(
            child: Text(
              'Cadastrar',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
