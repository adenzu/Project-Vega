import 'package:app/shuttle_creation/shuttle_creation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ShuttleCreationWidget extends StatelessWidget {
  final double iconSize;

  const ShuttleCreationWidget({Key? key, required this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: iconSize,
      icon:
          const Icon(CupertinoIcons.refresh_circled_solid, color: Colors.blue),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ShuttleCreationScreen()),
        );
      },
    );
  }
}
