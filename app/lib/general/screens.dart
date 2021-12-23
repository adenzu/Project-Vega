import 'package:flutter/cupertino.dart';

import '../child_profiles/screen.dart';
import '../about/screen.dart';
import '../feedback/screen.dart';
import '../my_shuttles_map/screen.dart';
import '../my_shuttles/screen.dart';
import '../profile/screen.dart';
import '../settings/screen.dart';
import '../main/screen.dart';

class ScreenNames {
  ScreenNames._();

  static const main = 'main';
  static const profile = 'profile';
  static const myShuttle = 'myShuttle';
  static const childProfiles = 'childProfiles';
  static const map = 'map';
  static const about = 'about';
  static const feedback = 'feedback';
  static const settings = 'settings';
}

class Screens {
  Screens._();

  static const main = MainScreen();
  static const profile = ProfileScreen();
  static const myShuttle = MyShuttleScreen();
  static const childProfiles = ChildProfilesScreen();
  static const myShuttleMap = MyShuttleMap();
  static const about = AboutScreen();
  static const feedback = FeedbackScreen();
  static const settings = SettingsScreen();

  static const Map<String, Widget> screenMap = {
    ScreenNames.main: Screens.main,
    ScreenNames.profile: Screens.profile,
    ScreenNames.myShuttle: Screens.myShuttle,
    ScreenNames.childProfiles: Screens.childProfiles,
    ScreenNames.map: Screens.myShuttleMap,
    ScreenNames.about: Screens.about,
    ScreenNames.feedback: Screens.feedback,
    ScreenNames.settings: Screens.settings,
  };
}
