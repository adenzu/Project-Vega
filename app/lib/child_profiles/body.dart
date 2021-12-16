import 'package:flutter/material.dart';

import 'button_block.dart';
import 'add_child_button.dart';
import '../child_profiles/screen.dart';

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //margin: const EdgeInsets.all(20),
      body: ButtonsBlock(),
    );
  }
}
