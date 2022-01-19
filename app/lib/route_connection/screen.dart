import 'package:app/route_connection/body.dart';
import 'package:flutter/material.dart';

class RouteConnectionScreen extends StatelessWidget {
  final userId;

  const RouteConnectionScreen({Key? key, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Rotaya Bağlan"),
        foregroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: RouteConnectionBody(userId: userId),
    );
  }
}
