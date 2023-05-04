import 'package:bukuing/screen/signup.dart';
//import 'dart:async';
import 'package:bukuing/screen/startingpage.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
  //await Firebase.initializeApp();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StartingPage2Widget(),
    );
  }
}
