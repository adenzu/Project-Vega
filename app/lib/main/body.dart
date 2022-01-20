import 'package:app/database/functions.dart';
import 'package:app/general/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
              iconBackgroundColor: Colors.white70,
              text: "Profil",
              imageName: "assets/images/profiles.jpeg",
              screenName: ScreenNames.profile,
              height: buttonHeight,
              navigateTo: ProfileScreen(
                userId: getUserId(),
                editable: true,
                canSeeParents: true,
              ),
            ),
            seperator,
            MainPageRedirectionButton(
              icon: Icons.account_tree,
              iconBackgroundColor: Colors.white70,
              text: "Çocuklarım",
              imageName: "assets/images/branch.jpeg",
              screenName: ScreenNames.childProfiles,
              height: buttonHeight,
              navigateTo: const ChildProfilesScreen(),
            ),
            seperator,
            MainPageRedirectionButton(
              icon: Icons.airport_shuttle,
              iconBackgroundColor: Colors.white70,
              text: "Rotalar",
              height: buttonHeight,
              imageName: "assets/images/shuttleservice.jpeg",
              screenName: ScreenNames.myShuttle,
              navigateTo: const MyShuttleScreen(),
            ),
            seperator,
            MainPageRedirectionButton(
              icon: Icons.map,
              iconBackgroundColor: Colors.white70,
              text: "Harita",
              imageName: "assets/images/mapimage.jpeg",
              height: buttonHeight,
              screenName: ScreenNames.map,
              navigateTo: const MyShuttleMap(),
            ),
            seperator,
          ],
        ),
      ),
    );
  }
}
