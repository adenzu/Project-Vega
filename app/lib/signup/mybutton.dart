import 'package:flutter/material.dart';

class mybutton extends StatelessWidget {
  final Function() press;
  final String text;

  const mybutton({
    Key? key,
    required this.press,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: press,
      child: Container(
        width: 350,
        height: 40,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xa84c56a8),Color(0xf56776f5),Color(0xf57c2da8), Color(0xf5b749f5)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,

          ),
          borderRadius: BorderRadius.circular(10)
        ),
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Color(0xf5ffffbb)),
      ),
    ),
    );
  }
}