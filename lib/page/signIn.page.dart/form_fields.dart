import 'package:flutter/material.dart';

class FormFieds extends StatelessWidget {
  const FormFieds({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
              hintText: 'email', border: OutlineInputBorder()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: TextFormField(
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