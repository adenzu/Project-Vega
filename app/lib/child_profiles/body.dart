import 'package:flutter/material.dart';

import 'button_block.dart';

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //margin: const EdgeInsets.all(20),
      body: ButtonsBlock(),
    );
  }
}
