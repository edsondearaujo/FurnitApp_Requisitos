
import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300,
          height: 70,
          decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              'Cadastrar',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        )
      ],
    );
  }
}


