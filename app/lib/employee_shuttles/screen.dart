import 'package:flutter/material.dart';

import 'body.dart';

class EmployeeShuttlesScreen extends StatelessWidget {
  const EmployeeShuttlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Servislerim"),
        centerTitle: true,
        foregroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const EmployeeShuttlesBody(),
    );
  }
}
