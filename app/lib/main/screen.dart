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
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFD8D8D8),
      drawer: SlideMenu(),
      body: const MainBody(),
    );
  }
}
