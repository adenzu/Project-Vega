import '../my_shuttle_screen/my_shuttle_screen.dart';
import 'package:flutter/cupertino.dart';

//import '../about/screen.dart';
//import '../child_profiles/screen.dart';
//import '../feedback/screen.dart';
//import '../map/screen.dart';
//import '../my_shuttles/screen.dart';
//import '../profile/screen.dart';
//import '../settings/screen.dart';
import '../main/screen.dart';

class ScreenNames {
  ScreenNames._();

  static const main = 'main';
  static const profile = 'profile';
  static const myShuttles = 'myShuttles';
  static const childProfiles = 'childProfiles';
  static const map = 'map';
  static const about = 'about';
  static const feedback = 'feedback';
  static const settings = 'settings';
}

class Screens {
  Screens._();

  static const main = MainScreen();
  //static const profile = ProfileScreen();
  static const myShuttles = MyShuttleScreen();
  //static const childProfiles = ChildProfilesScreen();
  //static const map = MapScreen();
  //static const about = AboutScreen();
  //static const feedback = FeedbackScreen();
  //static const settings = SettingsScreen();

  static const Map<String, Widget> screenMap = {
    ScreenNames.main: Screens.main,
    //ScreenNames.profile: Screens.profile,
    ScreenNames.myShuttles: Screens.myShuttles,
    //ScreenNames.childProfiles: Screens.childProfiles,
    //ScreenNames.map: Screens.map,
    //ScreenNames.about: Screens.about,
    //ScreenNames.feedback: Screens.feedback,
    //ScreenNames.settings: Screens.settings,
  };
}
