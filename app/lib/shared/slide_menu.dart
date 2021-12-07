import 'package:flutter/material.dart';

import '../general/screens.dart';
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
      "onTap": (context) => Navigator.of(context).pushNamed(ScreenNames.main),
    },
    {
      "isDivider": false,
      "title": "Profilim",
      "iconData": Icons.account_circle,
      "onTap": (context) =>
          Navigator.of(context).pushNamed(ScreenNames.profile),
    },
    {
      "isDivider": false,
      "title": "Servislerim",
      "iconData": Icons.directions_bus,
      "onTap": (context) =>
          Navigator.of(context).pushNamed(ScreenNames.myShuttles),
    },
    {
      "isDivider": false,
      "title": "Bağlı Profiller",
      "iconData": Icons.account_tree,
      "onTap": (context) =>
          Navigator.of(context).pushNamed(ScreenNames.childProfiles),
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
    // NOTE: servis yetkilisi modundayken gözükmeli
    {
      "isDivider": true,
    },
    {
      "isDivider": false,
      "title": "Bildir",
      "iconData": Icons.mail,
      "onTap": ((context) =>
          Navigator.of(context).pushNamed(ScreenNames.feedback)),
    },
    {
      "isDivider": false,
      "title": "Hakkında",
      "iconData": Icons.info,
      "onTap": ((context) =>
          Navigator.of(context).pushNamed(ScreenNames.about)),
    },
    {
      "isDivider": false,
      "title": "Ayarlar",
      "iconData": Icons.settings,
      "onTap": ((context) =>
          Navigator.of(context).pushNamed(ScreenNames.settings)),
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
