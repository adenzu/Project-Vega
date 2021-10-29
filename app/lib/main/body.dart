import 'package:flutter/material.dart';

import 'list_block.dart';

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        ListBlock(),
      ],
    );
  }
}
