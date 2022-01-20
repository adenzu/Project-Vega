import 'package:app/employee_shuttles/screen.dart';
import 'package:app/login/screen.dart';
import 'package:app/pending_profiles/screen.dart';
import 'package:app/profile/edit_profile_page.dart';
import 'package:app/route_connection/screen.dart';
import 'package:app/shuttle_creation/shuttle_creation_screen.dart';
import 'package:app/signup/screen.dart';

import 'package:flutter/cupertino.dart';

import '../child_profiles/screen.dart';
import '../about/screen.dart';
import '../feedback/screen.dart';
import '../my_shuttles_map/screen.dart';
import '../my_shuttles/screen.dart';
import '../settings/screen.dart';
import '../main/screen.dart';

/// Sayfa isimleri, yeni bir sayfa yaptığınızda buraya ona ilişkin bir değer
/// atayın.
///
/// Örnek:
/// Servis ekleme yapılan bir sayfa için AddShuttPage gibi bir class yağtığınızda
/// buraya da `static const addShuttle = 'addShuttle';` şeklinde değer eklersiniz
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
  static const childUpdate = 'childUpdate';
  static const editProfile = 'editProfile';
  static const login = 'login';
  static const signup = 'signup';
  static const pendingUsers = 'pendingUsers';
  static const employeeShuttles = 'employeeShuttles';
  static const shuttleCreation = "shuttleCreation";
}

/// Yeni bir sayfa oluşturduğunuzda buraya ilişkin değişkeni ekleyin
/// screenMap mapine de var olanlar şeklinde yine eklersiniz
///
/// Örnek:
/// Servis ekleme yapılan bir sayfa için AddShuttPage gibi bir class yağtığınızda
/// buraya da `static const addShuttle = AddShuttPage();` şeklinde değer eklersiniz
/// ```
/// ...
/// ScreenNames.addShuttle: Screens.addShuttle,
/// ...
/// ```
class Screens {
  Screens._();

  static const main = MainScreen();
  static const myShuttle = MyShuttleScreen();
  static const childProfiles = ChildProfilesScreen();
  static const myShuttleMap = MyShuttleMap(shuttleId: 'S19');
  static const about = AboutScreen();
  static const feedback = FeedbackScreen();
  static const settings = SettingsScreen();
  static const editProfile = EditProfilePage();
  static const login = LoginScreen();
  static const signup = SignUp();
  static const pendingUsers = PendingUsersScreen();
  static const employeeShuttles = EmployeeShuttlesScreen();
  static const shuttleCreation = ShuttleCreationScreen();

  static const Map<String, Widget> screensMap = {
    ScreenNames.main: Screens.main,
    ScreenNames.myShuttle: Screens.myShuttle,
    ScreenNames.childProfiles: Screens.childProfiles,
    ScreenNames.map: Screens.myShuttleMap,
    ScreenNames.about: Screens.about,
    ScreenNames.feedback: Screens.feedback,
    ScreenNames.settings: Screens.settings,
    ScreenNames.editProfile: Screens.editProfile,
    ScreenNames.login: Screens.login,
    ScreenNames.signup: Screens.signup,
    ScreenNames.pendingUsers: Screens.pendingUsers,
    ScreenNames.employeeShuttles: Screens.employeeShuttles,
    ScreenNames.shuttleCreation: Screens.shuttleCreation,
  };
}
