import 'package:flutter/material.dart';

import 'form_fields.dart';
import 'signin_buttons.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Cadastro de usuário'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Spacer(),
              Expanded(
                flex: 2,
                child: FormFieds(),
              ),
              //buttons
              Expanded(
                flex: 2,
                child: SignInButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
