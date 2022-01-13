import 'package:app/shared/slide_menu.dart';
import 'package:flutter/material.dart';

import 'body.dart';

class PendingUsersScreen extends StatelessWidget {
  const PendingUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bağlantı İstekleri"),
        centerTitle: true,
        foregroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: SlideMenu(),
      body: const PendingUsersBody(),
    );
  }
}
