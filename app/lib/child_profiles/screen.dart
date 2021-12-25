import 'package:flutter/material.dart';

import 'body.dart';

class ChildProfilesScreen extends StatelessWidget {
  const ChildProfilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Child Profiles"),
        foregroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: const MainBody(),
    );
  }
}
