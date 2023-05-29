import 'package:bukuing/screen/homepage.dart';
import 'package:bukuing/screen/signup.dart';
//import 'dart:async';
import 'package:bukuing/screen/startingpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePageWidget(),
    );
  }
}

class _AppState extends State<StatefulWidget> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: StartingPage2Widget());
  }
}
