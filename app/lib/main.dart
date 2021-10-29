import 'package:flutter/material.dart';

import 'main/page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppScreen _currentScreen = AppScreen.mainScreen;

  void _switchScreen(AppScreen screen) {
    setState(() {
      _currentScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget returned;

    switch (_currentScreen) {
      case AppScreen.mainScreen:
        returned = MainScreen();
        break;
      default:
        returned = MaterialApp();
    }

    return returned;
  }
}

enum AppScreen { mainScreen }
