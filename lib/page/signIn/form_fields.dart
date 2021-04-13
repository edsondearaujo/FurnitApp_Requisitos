import 'package:flutter/material.dart';
import 'package:furnitapp/bloc/signIn.bloc.dart';

class FormFieds extends StatelessWidget {
  const FormFieds({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: SignInBloc.validateEmail,
          controller: SignInBloc.emailController,
          decoration:
              InputDecoration(hintText: 'email', border: OutlineInputBorder()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: TextFormField(
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: SignInBloc.validatePassword,
            controller: SignInBloc.passwordController,
            decoration: InputDecoration(
              hintText: 'senha',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
