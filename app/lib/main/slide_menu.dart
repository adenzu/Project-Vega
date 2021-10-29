import 'package:flutter/material.dart';

import 'slide_menu_tile.dart';

class SlideMenu extends StatelessWidget {
  final List<Map<String, Object>> menuTiles = [
    {
      "isDivider": false,
      "title": "Ana Sayfa",
      "iconData": Icons.arrow_back,
      "onTap": (BuildContext context) => Navigator.pop(context),
    },
    {
      "isDivider": true,
    },
    {
      "isDivider": false,
      "title": "Profilim",
      "iconData": Icons.account_circle,
      "onTap": (BuildContext context) {},
    },
    {
      "isDivider": false,
      "title": "Servislerim",
      "iconData": Icons.directions_bus,
      "onTap": (BuildContext context) {},
    },
    {
      "isDivider": false,
      "title": "Bağlı Profiller",
      "iconData": Icons.account_tree,
      "onTap": (BuildContext context) {},
    },
    {
      "isDivider": true,
    },
    {
      "isDivider": false,
      "title": "Bildir",
      "iconData": Icons.mail,
      "onTap": (BuildContext context) {},
    },
    {
      "isDivider": false,
      "title": "Hakkında",
      "iconData": Icons.info,
      "onTap": (BuildContext context) {},
    },
    {
      "isDivider": false,
      "title": "Ayarlar",
      "iconData": Icons.settings,
      "onTap": (BuildContext context) {},
    },
    {
      "isDivider": false,
      "title": "Çıkış",
      "iconData": Icons.logout,
      "onTap": (BuildContext context) {},
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
