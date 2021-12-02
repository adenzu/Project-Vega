import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'main/screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const AlertDialog(
            title: Text("Something went wrong!"),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return const MaterialApp(home: MainScreen());
        }

        return const CircularProgressIndicator(
          color: Colors.blue,
        );
      },
    );
  }
}
