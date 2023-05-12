import 'package:bukuing/screen/homepage.dart';
import 'package:bukuing/screen/signup.dart';
//import 'dart:async';
import 'package:bukuing/screen/startingpage.dart';
import 'package:firebase_core/firebase_core.dart';
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

class _AppState extends State<StatefulWidget> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print(snapshot);
          return MaterialApp(home: StartingPage2Widget());
        }

        return MaterialApp(home: StartingPage2Widget()); //loading screen
      },
    );
  }
}

//      home: StartingPage2Widget(),
