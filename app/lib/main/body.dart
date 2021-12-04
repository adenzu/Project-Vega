import 'package:flutter/material.dart';

import 'package:app/map/screen.dart';
import 'package:app/profile/screen.dart';
import 'package:app/my_shuttles/screen.dart';
import 'package:app/child_profiles/screen.dart';

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
            MainPageRedirectionButton(
              icon: Icons.account_circle,
              iconBackgroundColor: Colors.purple,
              text: "Profil",
              imageName: "lib/materials/images/placeholder.png",
              builder: (context) => const ProfileScreen(),
              height: 150,
            ),
            seperator,
            MainPageRedirectionButton(
              icon: Icons.account_tree,
              iconBackgroundColor: Colors.blue,
              text: "Bağlı Profiller",
              imageName: "lib/materials/images/placeholder.png",
              builder: (context) => const ChildProfilesScreen(),
              height: 150,
            ),
            seperator,
            MainPageRedirectionButton(
              icon: Icons.directions_bus,
              iconBackgroundColor: Colors.green,
              text: "Servisler",
              imageName: "lib/materials/images/placeholder.png",
              builder: (context) => const MyShuttlesScreen(),
              height: 150,
            ),
            seperator,
            MainPageRedirectionButton(
              icon: Icons.map,
              iconBackgroundColor: Colors.pink,
              text: "Harita",
              imageName: "lib/materials/images/map.png",
              builder: (context) => const MapScreen(),
            ),
            seperator,
          ],
        ),
      ),
    );
  }
}
