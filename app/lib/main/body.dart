import 'package:flutter/material.dart';

import 'redirection_button.dart';
import '../general/screens.dart';

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
              imageName: "lib/materials/images/placeholder.png",
              screenName: ScreenNames.profile,
              height: 150,
            ),
            seperator,
            const MainPageRedirectionButton(
              icon: Icons.account_tree,
              iconBackgroundColor: Colors.blue,
              text: "Bağlı Profiller",
              imageName: "lib/materials/images/placeholder.png",
              screenName: ScreenNames.childProfiles,
              height: 150,
            ),
            seperator,
            const MainPageRedirectionButton(
              icon: Icons.directions_bus,
              iconBackgroundColor: Colors.green,
              text: "Servisler",
              imageName: "lib/materials/images/placeholder.png",
              screenName: ScreenNames.myShuttles,
            ),
            seperator,
            const MainPageRedirectionButton(
              icon: Icons.map,
              iconBackgroundColor: Colors.pink,
              text: "Harita",
              imageName: "lib/materials/images/map.png",
              screenName: ScreenNames.map,
            ),
            seperator,
          ],
        ),
      ),
    );
  }
}
