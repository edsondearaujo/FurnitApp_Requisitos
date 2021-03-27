import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Fuser {
  final String id;
  final bool isAdmin;
  final String email;

  Fuser({@required this.id, @required this.isAdmin, @required this.email});

  factory Fuser.fromDocument(DocumentSnapshot document) {
    return Fuser(
      id: document.id,
        isAdmin: document.data()['isAdmin'], 
        email: document.data()['email'],);
  }
}
