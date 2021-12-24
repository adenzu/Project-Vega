import 'package:app/general/screens.dart';

import '../main/screen.dart';
import '../profile/redirection_button.dart';
import '../profile/screen.dart';
import '../profile/screen_helper.dart';
import '../my_shuttles/screen.dart';
import 'package:flutter/material.dart';

import '../profile/screen.dart';

import 'redirection_button.dart';

class ButtonsBlock extends StatelessWidget {
  const ButtonsBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        RedirectionButton(
          text: "Redirection to profile",
          screenName: ScreenNames.main,
        ),
        Expanded(child: SizedBox()),
        RedirectionButton(
          text: "Redirection to my shuttles",
          screenName: ScreenNames.myShuttle,
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
