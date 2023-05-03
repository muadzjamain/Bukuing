import 'package:bukuing/screen/signup.dart';
import 'package:bukuing/screen/startingpage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
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
