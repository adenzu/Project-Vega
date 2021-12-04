import 'package:app/shared/slide_menu.dart';
import 'package:flutter/material.dart';

class ChildProfilesScreen extends StatelessWidget {
  const ChildProfilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Child Profiles here"),
      ),
      drawer: SlideMenu(),
    );
  }
}
