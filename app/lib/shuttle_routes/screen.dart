import 'package:flutter/material.dart';

import 'body.dart';

class ShuttleRoutesScreen extends StatelessWidget {
  final String shuttleId;

  const ShuttleRoutesScreen({Key? key, required this.shuttleId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Rotalar"),
        foregroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ServiceRoutesBody(
        shuttleId: shuttleId,
      ),
    );
  }
}
