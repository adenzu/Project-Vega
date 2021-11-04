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
