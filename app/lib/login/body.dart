import 'package:app/database/functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../components/circular_button.dart';
import '../components/not_visible_text_field_container.dart';
import '../components/visible_text_field_container.dart';
import '../main/screen.dart';
import 'forgot_password.dart';
import '../signup/verification_screen.dart';

import '../../service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'login_screen_body_bottom.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({Key? key}) : super(key: key);

  @override
  _LoginScreenBodyState createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  Icon visibilityIcon = const Icon(Icons.visibility);
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  String _emailText = "";
  String _passwordText = "";
  AuthService _authService = AuthService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller1.dispose();
    controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView(children: <Widget>[
      SizedBox(
        height: size.height,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.15),
            const Text(
              "VEGA",
              style: TextStyle(
                fontSize: 40,
                letterSpacing: 2,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.07),
            VisibleTextFieldContainer(
              hintText: "Email",
              changed: (text) => _emailText = text,
              controller: controller1,
              preIcon: const Icon(Icons.person),
            ),
            NotVisibleTextFieldContainer(
              hintText: "Password",
              changed: (text) => _passwordText = text,
              controller: controller2,
              preIcon: const Icon(Icons.lock),
            ),
            SizedBox(height: size.height * 0.04),
            CircularButton(
              buttonText: "LOGIN",
              press: () async {
                try {
                  // await _authService.SignIn( _emailText,_passwordText)
                  //     .then((_) {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const VerifyScreen()),
                  //     );
                  //
                  // });
                  User? user =
                      await _authService.SignIn(_emailText, _passwordText);
                  if (user == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VerifyScreen()),
                    );
                  } else {
                    addFCMToken();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainScreen()),
                    );
                  }
                } on FirebaseAuthException catch (e) {
                  Fluttertoast.showToast(
                      msg: e.message.toString(),
                      gravity: ToastGravity.CENTER,
                      textColor: Colors.red);
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            TextButton(
              onPressed: () {
                print("Please try to remember your password!");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPassword()),
                );
              },
              child: const Text(
                "Forgot Password?",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: size.height * 0.2),
            const LoginScreeBodyBottom(),
          ],
        ),
      ),
    ]);
  }
}
