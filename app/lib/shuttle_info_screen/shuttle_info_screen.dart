import 'package:flutter/material.dart';
import 'shuttle_info_screen_body.dart';

class ShuttleInfoScreen extends StatelessWidget {
  final int shuttleID;

  const ShuttleInfoScreen({Key? key, required this.shuttleID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8D8D8),
      body: ShuttleInfoScreenBody(
        shuttleID: shuttleID,
      ),
    );
  }
}
