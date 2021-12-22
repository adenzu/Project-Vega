import 'package:app/components/circular_button.dart';
import 'package:app/components/visible_text_field_container.dart';
import 'package:app/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  Icon visibilityIcon = const Icon(Icons.visibility);
  final controller1 = TextEditingController();
  String _emailText = "";
  AuthService _authService = AuthService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(

      body: ListView(children: <Widget>[
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
              SizedBox(height: size.height * 0.04),
              CircularButton(
                buttonText: "SEND",
                press: () {
                  setState(() async {
                    try {
                      _authService.forgotPassword( _emailText);
                      Navigator.of(context).pop();
                    } on FirebaseAuthException catch (e) {
                      Fluttertoast.showToast(
                          msg: e.message.toString(),
                          gravity: ToastGravity.CENTER,
                          textColor: Colors.red);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
