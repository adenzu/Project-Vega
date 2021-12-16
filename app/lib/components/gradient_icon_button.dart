import 'package:flutter/material.dart';

class GradientIconButton extends StatelessWidget {

  final double iconSize;
  final Icon icon;
  final void Function() press;

  const GradientIconButton({Key? key,
    required this.icon,
    required this.iconSize,
    required this.press,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xa84c56a8),
            Color(0xf56776f5),
            Color(0xf57c2da8),
            Color(0xf5b749f5)
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.white,
          ),
          child: IconButton(
            onPressed: press,
            icon: icon,
            iconSize: iconSize,
          ),
        ),
      ),
    );
  }
}
