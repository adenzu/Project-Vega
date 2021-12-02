import 'package:flutter/material.dart';
import '../general/util.dart';

class RedirectionButton extends StatelessWidget {
  final String text;
  final Widget Function(BuildContext) builder;

  const RedirectionButton({
    Key? key,
    required this.text,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 105,
      height: 100,
      child: ElevatedButton(
        onPressed: () => redirectionTo(builder)(context),
        child: Text(text),
      ),
    );
  }
}
