import 'package:flutter/material.dart';
import 'welcome_screen_body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WelcomeScreenBody(),
    );
  }
}
