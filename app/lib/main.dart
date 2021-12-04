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

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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

        return Center(
          child: CircularProgressIndicator(
            value: controller.value,
          ),
        );
      },
    );
  }
}
