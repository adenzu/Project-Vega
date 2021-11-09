import 'package:flutter/material.dart';

import 'list_block.dart';
import 'button_block.dart';
import 'search_button.dart';

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: const <Widget>[
          ListBlock(),
          SizedBox(height: 20), // SearchButton(),
          ButtonsBlock(),
        ],
      ),
    );
  }
}
