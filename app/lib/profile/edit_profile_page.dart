import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/profile/button_widget.dart';
import 'package:app/profile/redirection_button.dart';
import 'package:app/profile/screen.dart';
import 'package:app/profile/screen_helper.dart';
import 'package:flutter/material.dart';
import 'package:app/profile/user.dart';
import 'package:app/profile/user_preferences.dart';
import 'package:app/profile/appbar_widget.dart';
import 'package:app/profile/profile_widget.dart';
import 'package:app/profile/textfield_widget.dart';

import '../util.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;
  late String temp;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Builder(
          builder: (context) => Scaffold(
            appBar: buildAppBar(context),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: user.imagePath,
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Name',
                  text: user.name,
                  onChanged: (name) {UserPreferences.myUser.name = name;},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Surname',
                  text: user.surname,
                  onChanged: (surname) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: user.email,
                  onChanged: (email) {},
                ),
                TextFieldWidget(
                  label: 'Password',
                  text: user.password,
                  onChanged: (password) {},
                ),
                /*
                ElevatedButton(
                onPressed: () {
                  setState(() {
                    redirectionTo((context) => MyApp());
                  });
                },
                child: Text('Save'),
              ),
              */
              ButtonWidget(
          text: "Save",
          onClicked: () {
            print("sdgsdgsdgsdgsdg\n\n");
            //UserPreferences.myUser.name = temp;
            Navigator.pop(context);
             },
        ),
              
              
              ],
            ),
          ),
        ),
      );
}