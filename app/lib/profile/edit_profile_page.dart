import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/database/functions.dart';
import 'package:app/login/screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  String name = "";
  String surname = "";
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
                      labelText: 'Password',
                    ),
                    controller: _controller3,
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
                    style: TextButton.styleFrom(primary: Colors.blue),
                    onPressed: () async {
                      setState(() {
                        name = _controller.text;
                        surname = _controller2.text;
                        password = _controller3.text;
                      });

                      final FirebaseAuth _auth = FirebaseAuth.instance;
                      final FirebaseFirestore _firestore =
                          FirebaseFirestore.instance;
                      await _firestore
                          .collection('User')
                          .doc(_auth.currentUser!.uid)
                          .update({
                        'Name': name,
                        'Surname': surname,
                      });

                      final currentUser = FirebaseAuth.instance.currentUser;
                      await currentUser!.updatePassword(password);
                      FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.orangeAccent,
                          content: Text(
                            'Your Password has been changed. Login again!',
                            style: TextStyle(fontSize: 18),
                          )));
                      /*
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => abc()),
                         );
                         */
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
