import 'package:flutter/material.dart';

import '../profile/screen.dart';
import '../my_shuttles/screen.dart';
import '../child_profiles/screen.dart';

import 'redirection_button.dart';

class ButtonsBlock extends StatelessWidget {
  const ButtonsBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RedirectionButton(
          text: "Redirection to profile",
          builder: (context) => const ProfileScreen(),
        ),
        const Expanded(child: SizedBox()),
        RedirectionButton(
          text: "Redirection to my shuttles",
          builder: (context) => const MyShuttlesScreen(),
        ),
        const Expanded(child: SizedBox()),
        RedirectionButton(
          text: "Redirection to child profiles",
          builder: (context) => const ChildProfilesScreen(),
        ),
      ],
    );
  }
}
