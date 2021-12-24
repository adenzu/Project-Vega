import 'package:flutter/material.dart';

/// ExamplePage sayfasına yönlendirmek için redirectionTo(ScreenNames.examplePage)(context)
/// şeklinde kullan
///
/// Örnek:
/// ```
/// redirectionTo(ScreenNames.main)(context)
/// ```
Future Function(BuildContext) redirectionTo(String screenName) {
  return (context) => Navigator.of(context).pushNamed(screenName);
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
