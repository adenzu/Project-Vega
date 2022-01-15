// ignore_for_file: deprecated_member_use

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/database/functions.dart';
import 'package:app/login/screen.dart';
import 'package:app/profile/edit_name_page.dart';
import 'package:app/profile/edit_password_page.dart';
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
                    child: Text('Edit Name'),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditNamePage()),
                      );
                    },
                  ),
                  padding: EdgeInsets.all(32),
                ),
                Container(
                  width: double.infinity,
                  child: FlatButton(
                    child: Text('Edit Password'),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditPasswordPage()),
                      );
                    },
                  ),
                  padding: EdgeInsets.all(32),
                )
              ],
            ),
          ),
        ),
      );

/*
    return MaterialApp(
      title: "Update Info",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Update Info"),
          centerTitle: true,
        ),
        body: Container(
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: <Widget>[
              FlatButton(
                child: Text("Edit Name"),
                color: Colors.green, 
                textColor: Colors.white,
                onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditNamePage()),
                  );  },
              ),
              FlatButton(
                child: Text("Edit Password"),
                color: Colors.green, 
                textColor: Colors.white,
                onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditPasswordPage()),
                  );  },
              )
            ]
          )
        )
      )
    );
*/
/*
       return Scaffold(
       
         Container(
           
            child: Row(
              children: <Widget>[
                Expanded(
              child:FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditNamePage()),
                  );
                },
                child: Text("Edit Name"),
                color: Colors.lightBlue
                ),
                ),
                Expanded(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditPasswordPage()),
                  );
                },
                child: Text("Edit Password"),
                color: Colors.lightBlue
                ),
                )
            ]
          
      )
         

       )
       );
       */
}
