import 'package:flutter/material.dart';

import 'package:app/shared/slide_menu.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Map screen here"),
      ),
      drawer: SlideMenu(),
    );
  }
}
