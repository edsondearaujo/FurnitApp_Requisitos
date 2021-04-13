import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:furnitapp/page/showProducts/products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: ProductScreen(),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
