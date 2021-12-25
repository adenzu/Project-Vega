import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/general/screens.dart';
import 'package:app/general/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../profile/user.dart';
import '../profile/edit_profile_page.dart';
import '../profile/user_preferences.dart';
import '../profile/appbar_widget.dart';
import '../profile/button_widget.dart';
import '../profile/profile_widget.dart';
import '../profile/redirection_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      body: Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: user.imagePath,
                onClicked: () =>
                    redirectionTo(ScreenNames.editProfile)(context),
              ),
              const SizedBox(height: 24),
              buildName(user),
              const SizedBox(height: 24),
              Center(child: buildUpgradeButton()),
              const SizedBox(height: 48),
              const RedirectionButton(
                text: "Update Info",
                screenName: ScreenNames.editProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade To Shuttle Employee',
        onClicked: () {},
      );
}
