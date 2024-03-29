import 'package:flutter/material.dart';
import 'package:furnitapp/bloc/signUp.bloc.dart';
import 'package:furnitapp/constants.dart';
import 'package:furnitapp/page/showProducts/products_screen.dart';

class SignUpButton extends StatelessWidget {
  final SignUpBloc signUpBloc = SignUpBloc();

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
            bool isOk = await signUpBloc.signup(
                email: SignUpBloc.emailController.text,
                password: SignUpBloc.passwordController.text);
            if (isOk) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(),
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
