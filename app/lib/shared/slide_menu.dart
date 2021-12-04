import 'package:flutter/material.dart';

import 'package:app/main/screen.dart';
import 'package:app/about/screen.dart';
import 'package:app/profile/screen.dart';
import 'package:app/settings/screen.dart';
import 'package:app/feedback/screen.dart';
import 'package:app/my_shuttles/screen.dart';
import 'package:app/child_profiles/screen.dart';
import 'package:app/general/util.dart';

import 'slide_menu_tile.dart';

class SlideMenu extends StatelessWidget {
  final List<Map<String, Object>> menuTiles = [
    {
      "isDivider": false,
      "title": "Geri",
      "iconData": Icons.arrow_back,
      "onTap": (context) => Navigator.pop(context),
    },
    {
      "isDivider": true,
    },
    {
      "isDivider": false,
      "title": "Ana Sayfa",
      "iconData": Icons.house,
      "onTap": redirectionTo((context) => const MainScreen()),
    },
    {
      "isDivider": false,
      "title": "Profilim",
      "iconData": Icons.account_circle,
      "onTap": redirectionTo((context) => const ProfileScreen()),
    },
    {
      "isDivider": false,
      "title": "Servislerim",
      "iconData": Icons.directions_bus,
      "onTap": redirectionTo((context) => const MyShuttlesScreen()),
    },
    {
      "isDivider": false,
      "title": "Bağlı Profiller",
      "iconData": Icons.account_tree,
      "onTap": redirectionTo((context) => const ChildProfilesScreen()),
    },
    {
      "isDivider": true,
    },
    // NOTE: servis yetkilisi modundayken gözükmeli
    {
      "isDivider": false,
      "title": "Servis ekle",
      "iconData": Icons.add,
      "onTap": (context) {},
    },
    {
      "isDivider": false,
      "title": "Değiştir",
      "iconData": Icons.swap_horiz,
      "onTap": (context) {},
    },
    {
      "isDivider": true,
    },
    {
      "isDivider": false,
      "title": "Bildir",
      "iconData": Icons.mail,
      "onTap": redirectionTo((context) => const FeedbackScreen()),
    },
    {
      "isDivider": false,
      "title": "Hakkında",
      "iconData": Icons.info,
      "onTap": redirectionTo((context) => const AboutScreen()),
    },
    {
      "isDivider": false,
      "title": "Ayarlar",
      "iconData": Icons.settings,
      "onTap": redirectionTo((context) => const SettingsScreen()),
    },
    {
      "isDivider": false,
      "title": "Çıkış",
      "iconData": Icons.logout,
      "onTap": (context) {},
    },
  ];

  SlideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        padding: const EdgeInsets.only(
          top: 22,
        ),
        itemCount: menuTiles.length,
        itemBuilder: (BuildContext context, int index) {
          var tile = menuTiles[index];

          if (tile["isDivider"] as bool) {
            return const Divider();
          } else {
            return SlideMenuTile(
              title: tile["title"] as String,
              iconData: tile["iconData"] as IconData,
              onTap: () => (tile["onTap"] as Function)(context),
            );
          }
        },
      ),
    );
  }
}
