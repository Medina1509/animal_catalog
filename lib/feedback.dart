import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Второе окно')),
      body: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Введите ваш вопрос",
          fillColor: Colors.black54,
          filled: false,
        ),
      ),
    );
  }
}
