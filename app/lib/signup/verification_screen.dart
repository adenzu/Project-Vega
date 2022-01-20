import 'dart:async';

import 'package:app/database/functions.dart';

import '../main/screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _authService = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = _authService.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    user = _authService.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      addFCMToken();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
              'An email has been sent to ${user.email}, Please verify your account')),
    );
  }
}