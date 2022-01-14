import 'package:flutter/material.dart';

import 'shuttle_creation_screen1.dart';

class ShuttleCreationScreen extends StatelessWidget {
  const ShuttleCreationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFD8D8D8),
      //resizeToAvoidBottomInset: false,
      body: ShuttleCreationScreen1(),
    );
  }
}
