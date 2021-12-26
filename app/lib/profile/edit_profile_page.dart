import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/database/functions.dart';
import '../profile/button_widget.dart';
import '../profile/redirection_button.dart';
import '../profile/screen.dart';
import '../profile/screen_helper.dart';
import 'package:flutter/material.dart';
import '../profile/user.dart';
import '../profile/user_preferences.dart';
import '../profile/appbar_widget.dart';
import '../profile/profile_widget.dart';
import '../profile/textfield_widget.dart';

import '../general/util.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  User user = UserPreferences.myUser;
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();
  String name = "";
  String surname = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Builder(
          builder: (context) => Scaffold(
            appBar: buildAppBar(context),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                ProfileWidget(
                  imagePath: user.imagePath,
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                    controller: _controller,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Surname',
                    ),
                    controller: _controller2,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                    controller: _controller3,
                  ),
                ),
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    controller: _controller4,
                  ),
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
                /*
                ButtonWidget(
                  text: "Save",
                  onClicked: () {
                   
                    //UserPreferences.myUser.name = temp;
                    Navigator.pop(context);
                  },
                ),
                */
                Container(
                  width: double.infinity,
                  child: TextButton(
                    child: Text('Save'),
                    style: const ButtonStyle(
                        // backgroundColor: MaterialStateProperty.all(Color: Colors.blue),
                        ),
                    onPressed: () {
                      setState(() {
                        name = _controller.text;
                        surname = _controller2.text;
                        email = _controller3.text;
                        password = _controller4.text;
                      });

                      /// Firestore database için fonksiyon
                      /// yazılmadı daha
                      //  updateUserInfo({'name':name});
                      //  updateUserInfo({'surname':surname});
                      Navigator.pop(context);
                    },
                  ),
                  padding: EdgeInsets.all(32),
                )
              ],
            ),
          ),
        ),
      );
}
