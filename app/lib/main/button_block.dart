import 'package:app/main/screen.dart';
import 'package:app/profile/redirection_button.dart';
import 'package:app/profile/screen.dart';
import 'package:app/profile/screen_helper.dart';
import 'package:app/screens/my_shuttle_screen/my_shuttle_screen.dart';
import 'package:flutter/material.dart';

import '../profile/screen.dart';


import 'redirection_button.dart';

class ButtonsBlock extends StatelessWidget {
  const ButtonsBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RedirectionButton(
          text: "Redirection to profile",
          builder: (context) => const MainScreen(),
        ),
        const Expanded(child: SizedBox()),
        RedirectionButton(
          text: "Redirection to my shuttles",
          builder: (context) => const MyShuttleScreen(),
        ),
        // const Expanded(child: SizedBox()),
        // RedirectionButton(
        //   text: "Redirection to child profiles",
        //   builder: (context) => const ChildProfilesScreen(),
        // ),
      ],
    );
  }
}
