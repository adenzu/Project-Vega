import '../shared/slide_menu.dart';
import 'package:flutter/material.dart';

import 'body.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
      ),
      body: const SettingsBody(),
      drawer: SlideMenu(),
    );
  }
}
