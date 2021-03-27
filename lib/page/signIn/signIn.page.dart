import 'package:flutter/material.dart';
import 'package:furnitapp/bloc/signIn.bloc.dart';
import 'package:furnitapp/constants.dart';
import 'package:furnitapp/page/home_page.dart';
import 'package:furnitapp/page/signUp/signUp.page.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool displayError = false;
  bool displayCircularProgress = false;

  SignInBloc signInBloc = SignInBloc();

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            //Title
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: Text(
                    'Seja bem-vindo(a)!',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: kTextLightColor),
                  ),
                ),
              ),
            ),
            //FormFields
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: SignInBloc.validateEmail,
                      controller: SignInBloc.emailController,
                      decoration: InputDecoration(
                        hintText: 'email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          obscureText: true,
                          controller: SignInBloc.passwordController,
                          decoration: InputDecoration(
                            hintText: 'senha',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        displayError
                            ? Text(
                                'Email ou senha errada!',
                                style: TextStyle(color: Colors.red),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            displayCircularProgress
                ? Expanded(
                    flex: 2,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Column(
                        children: [
                          //Entrar
                          InkWell(
                            onTap: () async {
                              setState(() {
                                displayCircularProgress =
                                    !displayCircularProgress;
                              });
                              int response = await signInBloc.signIn(
                                  email: SignInBloc.emailController.text,
                                  password: SignInBloc.passwordController.text);

                              if (response == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              } else {
                                setState(() {
                                  displayError = true;
                                  displayCircularProgress =
                                      !displayCircularProgress;
                                });
                              }
                            },
                            child: Container(
                              width: 300,
                              height: 70,
                              decoration: BoxDecoration(
                                color: kSecondaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Entrar',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUp(),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 40),
                              child: Text(
                                'Cadastrar',
                                style: TextStyle(color: kTextLightColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
