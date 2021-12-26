import 'package:flutter/material.dart';
import '../shared/slide_menu.dart';
import 'body.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Project-Vega",
        ),
        foregroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: SlideMenu(),
      body: const MainBody(),
    );
  }
}
