import 'package:flutter/material.dart';

class LoginScreeBodyBottom extends StatelessWidget {
  const LoginScreeBodyBottom({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(Icons.call, color: Color(0xDD490A0A)),
        SizedBox(width: 10),
        Icon(Icons.message, color: Color(0xDD490A0A)),
        SizedBox(width: 10),
        Icon(Icons.web, color: Color(0xDD490A0A)),
        SizedBox(width: 10),
        Text("/VegaShuttleApp",
            style: TextStyle(fontSize: 20, color: Color(0xDD490A0A))),
      ],
    );
  }
}
