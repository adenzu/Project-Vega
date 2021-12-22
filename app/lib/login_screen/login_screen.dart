import 'package:flutter/material.dart';
import 'login_screen_body.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFD8D8D8),
      body: LoginScreenBody(),
    );
  }
}
