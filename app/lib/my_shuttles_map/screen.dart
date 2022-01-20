import 'package:flutter/material.dart';
import 'body.dart';

class MyShuttleMap extends StatelessWidget {
  final String shuttleId;
  const MyShuttleMap({Key? key, required this.shuttleId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyShuttleMapBody(shuttleId: shuttleId,),
    );
  }
}
