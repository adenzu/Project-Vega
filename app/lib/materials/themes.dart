import 'package:flutter/material.dart';

class ThemeIds {
  ThemeIds._();

  static const light = 0;
  static const dark = 1;
}

class Themes {
  Themes._();

  static final map = {
    ThemeIds.light: ThemeData.light(),
    ThemeIds.dark: ThemeData.dark(),
  };
}
