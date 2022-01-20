
import 'package:app/route/routes_body.dart';
import 'package:flutter/material.dart';

class RouteScreen extends StatelessWidget {
 final String routeID;
  const RouteScreen({Key? key,required this.routeID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: const Color(0xFFD8D8D8),
      body: RouteBody(routeID: routeID),
    );
  }
}
