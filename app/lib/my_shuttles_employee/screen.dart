import 'package:flutter/material.dart';
import 'body.dart';

class MyShuttleEmployeeScreen extends StatelessWidget {
  const MyShuttleEmployeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFD8D8D8),
      body: MyShuttleEmployeeScreenBody(),
    );
  }
}