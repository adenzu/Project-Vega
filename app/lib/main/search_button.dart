import 'package:app/search/screen.dart';
import 'package:flutter/material.dart';

import '../util.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () =>
          redirectionTo((context) => const SearchScreen())(context),
      child: const Text("Arama"),
    );
  }
}
