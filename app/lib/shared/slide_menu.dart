import 'package:app/database/functions.dart';
import 'package:app/general/util.dart';
import 'package:app/profile/screen.dart';
import 'package:app/route_connection/screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../general/screens.dart';
import 'slide_menu_tile.dart';

void Function(BuildContext) redirectOrPop(String screenName) {
  return (context) => isScreenName(screenName)(context)
      ? Navigator.pop(context)
      : redirectionTo(screenName)(context);
}

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
      "onTap": redirectOrPop(ScreenNames.main),
    },
    {
      "isDivider": false,
      "title": "Profilim",
      "iconData": Icons.account_circle,
      "onTap": (context) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                userId: getUserId(),
                editable: true,
                canSeeParents: true,
              ),
            ),
          ),
    },
    {
      "isDivider": false,
      "title": "Rotalarım",
      "iconData": Icons.map,
      "onTap": redirectOrPop(ScreenNames.myShuttle),
    },
    {
      "isDivider": false,
      "title": "Çocuklarım",
      "iconData": Icons.account_tree,
      "onTap": redirectOrPop(ScreenNames.childProfiles),
    },
    {
      "isDivider": false,
      "title": "Rotaya Bağlan",
      "iconData": Icons.add_link,
      "onTap": (context) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RouteConnectionScreen(
                userId: getUserId(),
              ),
            ),
          ),
    },
    {
      "isDivider": true,
    },
    {
      "isDivider": false,
      "title": "Görevli Servislerim",
      "iconData": Icons.airport_shuttle,
      "onTap": redirectOrPop(ScreenNames.employeeShuttles),
    },
    {
      "isDivider": true,
    },
    {
      "isDivider": false,
      "title": "Bağlantı istekleri",
      "iconData": Icons.pending_actions,
      "onTap": redirectOrPop(ScreenNames.pendingUsers),
    },
    // {
    //   "isDivider": false,
    //   "title": "Bildir",
    //   "iconData": Icons.mail,
    //   "onTap": redirectOrPop(ScreenNames.feedback),
    // },
    // {
    //   "isDivider": false,
    //   "title": "Hakkında",
    //   "iconData": Icons.info,
    //   "onTap": redirectOrPop(ScreenNames.about),
    // },
    {
      "isDivider": false,
      "title": "Ayarlar",
      "iconData": Icons.settings,
      "onTap": redirectOrPop(ScreenNames.settings),
    },
    {
      "isDivider": false,
      "title": "Çıkış",
      "iconData": Icons.logout,
      "onTap": (context) {
        removeFCMToken().then((value) {
          FirebaseAuth.instance.signOut();
          Navigator.pushNamedAndRemoveUntil(
              context, ScreenNames.login, (route) => false);
        });
      },
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
