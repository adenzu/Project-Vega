import 'package:flutter/material.dart';
import '../general/util.dart';

class RedirectionButton extends StatelessWidget {
  final String text;
  final String screenName;

  const RedirectionButton({
    Key? key,
    required this.text,
    required this.screenName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: ElevatedButton(
        onPressed: () => redirectionTo(screenName)(context),
        child: Text(text),
      ),
    );
  }
}
