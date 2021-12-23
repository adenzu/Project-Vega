import 'package:flutter/material.dart';
import 'body.dart';

class MyShuttleMap extends StatelessWidget {
  const MyShuttleMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyShuttleMapBody(),
    );
  }
}
