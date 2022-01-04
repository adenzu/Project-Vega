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

class EditNamePage extends StatefulWidget {
  const EditNamePage({Key? key}) : super(key: key);

  @override
  _EditNamePageState createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  
  final _controller = TextEditingController();
  final _controller2 = TextEditingController();
  String name = "";
  String surname = "";

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
                  child: FlatButton(
                    child: Text('Save'),
                    color:Colors.blue,
                    onPressed: () async {
                      setState(() {
                         name = _controller.text;
                         surname = _controller2.text;
                      });
                      
                      final FirebaseAuth _auth = FirebaseAuth.instance;
                      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                         await _firestore.collection('User').doc(_auth.currentUser!.uid)
                        .update({
                        'Name': name,
                        'Surname':surname,
                       });

                       
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => abc()),
                         );
                         
                    }, ),
                    padding: EdgeInsets.all(32),
                    )
              ],
            ),
          ),
        ),
      );
}