import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/profile/user.dart';
import 'package:app/profile/edit_profile_page.dart';
import 'package:app/profile/user_preferences.dart';
import 'package:app/profile/appbar_widget.dart';
import 'package:app/profile/button_widget.dart';
import 'package:app/profile/profile_widget.dart';
import 'package:app/profile/redirection_button.dart';

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
                  onClicked: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditProfilePage()),
                    );
                  },
                ),
                const SizedBox(height: 24),
                buildName(user),
                const SizedBox(height: 24),
                Center(child: buildUpgradeButton()),
                const SizedBox(height: 48),
                RedirectionButton(
                  text: "Update Info",
                  builder: (context) => EditProfilePage(),
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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