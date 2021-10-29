import 'package:flutter/material.dart';

import 'slide_menu.dart';
import 'body.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Project-Vega",
          ),
          centerTitle: true,
        ),
        drawer: SlideMenu(),
        body: MainBody(),
      ),
    );
  }
}
