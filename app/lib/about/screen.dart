import 'package:flutter/material.dart';

import '../shared/slide_menu.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About screen here"),
      ),
      drawer: SlideMenu(),
    );
  }
}
