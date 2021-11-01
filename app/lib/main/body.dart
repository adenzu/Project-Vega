import 'package:flutter/material.dart';
import 'package:app/main/list_block.dart';
import 'package:app/main/redirection.dart';
import 'package:app/main/search_bar.dart';

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Column(
      children:  <Widget>[
        ListBlock(),
        SearchBar(),
        Redirection(),
      ],
    );
  }
  
}
