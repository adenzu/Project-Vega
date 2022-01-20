import 'package:app/route/routes_body.dart';
import 'package:flutter/material.dart';

class RouteScreen extends StatelessWidget {
  final String routeID;

  const RouteScreen({Key? key, required this.routeID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Kod: ${routeID}",
                style: TextStyle(color: Colors.grey[800]),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        foregroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: RouteBody(
      routeID: routeID,
      ),
    );
  }
}
