import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  final Icon icon;

  const GradientIcon({Key? key,
    required this.icon,
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
          child: icon,
        ),
      ),
    );
  }
}
