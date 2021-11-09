import 'package:flutter/material.dart';

Future Function(BuildContext) redirectionTo(
    Widget Function(BuildContext) builder) {
  return (BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: builder,
        ),
      );
}

Future<T?> showTightModalBottomSheet<T>({
  required BuildContext context,
  required List<Widget> children,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return Wrap(children: children);
    },
  );
}
