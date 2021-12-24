import 'package:flutter/material.dart';

import '../child_profiles/screen.dart';
import '../my_shuttles_map/screen.dart';
import '../profile/screen.dart';
import '../my_shuttles/screen.dart';
import '../general/screens.dart';

import 'redirection_button.dart';

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double seperation = 15;
    double buttonHeight = 130;
    SizedBox seperator = SizedBox(height: seperation);
    return Container(
      margin: EdgeInsets.fromLTRB(seperation, 0, seperation, 0),
      child: Center(
        child: ListView(
          children: <Widget>[
            seperator,
            MainPageRedirectionButton(
              icon: Icons.account_circle,
              iconBackgroundColor: Colors.purple,
              text: "Profil",
              imageName: "assets/images/profiles.jpeg",
              screenName: ScreenNames.profile,
              height: buttonHeight,
              navigateTo: ProfileScreen(),
            ),
            seperator,
            MainPageRedirectionButton(
              icon: Icons.account_tree,
              iconBackgroundColor: Colors.blue,
              text: "Bağlı Profiller",
              imageName: "assets/images/branch.jpeg",
              screenName: ScreenNames.childProfiles,
              height: buttonHeight,
              navigateTo: ChildProfilesScreen(),
            ),
            seperator,
            MainPageRedirectionButton(
              icon: Icons.directions_bus,
              iconBackgroundColor: Colors.green,
              text: "Servisler",
              height: buttonHeight,
              imageName: "assets/images/shuttleservice.jpeg",
              screenName: ScreenNames.myShuttle,
              navigateTo: MyShuttleScreen(),
            ),
            seperator,
            MainPageRedirectionButton(
              icon: Icons.map,
              iconBackgroundColor: Colors.pink,
              text: "Harita",
              imageName: "assets/images/mapimage.jpeg",
              height: buttonHeight,
              screenName: ScreenNames.map,
              navigateTo: MyShuttleMap(),
            ),
            seperator,
          ],
        ),
      ),
    );
  }
}
