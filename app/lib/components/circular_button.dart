import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final String buttonText;
  final Color textColor;
  final void Function() press;
  final double radius;
  final double size;

  const CircularButton({
    Key? key,
    required this.press,
    required this.buttonText,
    this.textColor = const Color(0xf5ffffbb),
    this.radius = 30.0,
    this.size = 0.8,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Size sizeT = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: sizeT.width * size,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xa84c56a8),Color(0xf56776f5),Color(0xf57c2da8), Color(0xf5b749f5)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            textStyle: const TextStyle(fontSize: 30),

          ),
          onPressed: press,
          child: Text(buttonText, style: TextStyle(color: textColor)),
        ),
      ),
    );
  }
}
