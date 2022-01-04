import 'package:flutter/material.dart';

/// ExamplePage sayfasına yönlendirmek için redirectionTo(ScreenNames.examplePage)(context)
/// şeklinde kullan
///
/// Örnek:
/// ```
/// redirectionTo(ScreenNames.main)(context)
/// ```
Future Function(BuildContext) redirectionTo(String screenName) {
  return (context) => Navigator.pushNamed(context, screenName);
}

/// ekrandaki sayfanın verilen sayfa olup olmadığını kontrol eden fonksiyon döndürür
///
/// Örnek:
/// ```
/// isScreenName(ScreenNames.main)(context)
/// ```
bool Function(BuildContext) isScreenName(String screenName) {
  return (context) => ModalRoute.of(context)?.settings.name == screenName;
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
