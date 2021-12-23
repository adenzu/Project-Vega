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
    double seperation = 20;
    SizedBox seperator = SizedBox(height: seperation);
    return Container(
      margin: EdgeInsets.fromLTRB(seperation, 0, seperation, 0),
      child: Center(
        child: ListView(
          children: <Widget>[
            seperator,
            const MainPageRedirectionButton(
              icon: Icons.account_circle,
              iconBackgroundColor: Colors.purple,
              text: "Profil",
              imageName: "assets/images/profiles.jpeg",
              screenName: ScreenNames.profile,
              height: 150,
              navigateTo: ProfileScreen(),
            ),
            seperator,
            const MainPageRedirectionButton(
              icon: Icons.account_tree,
              iconBackgroundColor: Colors.blue,
              text: "Bağlı Profiller",
              imageName: "assets/images/branch.jpeg",
              screenName: ScreenNames.childProfiles,
              height: 150,
              navigateTo: ChildProfilesScreen(),
            ),
            seperator,
            const MainPageRedirectionButton(
              icon: Icons.directions_bus,
              iconBackgroundColor: Colors.green,
              text: "Servisler",
              height: 150,
              imageName: "assets/images/shuttleservice.jpeg",
              screenName: ScreenNames.myShuttle,
              navigateTo: MyShuttleScreen(),
            ),
            seperator,
            const MainPageRedirectionButton(
              icon: Icons.map,
              iconBackgroundColor: Colors.pink,
              text: "Harita",
              imageName: "assets/images/mapimage.jpeg",
              height: 150,
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
