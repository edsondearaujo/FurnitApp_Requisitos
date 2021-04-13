import 'package:flutter/material.dart';
import 'package:furnitapp/constants.dart';

import 'form_fields.dart';
import 'SignUp_button.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
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
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Text('Crie uma conta'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Spacer(),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FormFieds(),
                ),
              ),
              //buttons
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SignUpButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
