
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/general/screens.dart';
import 'package:app/general/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
   String? name =null;
   String? surname =null;
   String? email =null;

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
              buildName(),
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

  Widget buildName() => Column(
        children: [
          FutureBuilder(
          future: _fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
            return Text("Loading data...Please wait");
            return Text("Name : $name $surname");
          },
        ),
  
         
          const SizedBox(height: 4),
          FutureBuilder(
          future: _fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
            return Text("Loading data...Please wait");
            return Text("Email : $email");
          },
        ),
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade To Shuttle Employee',
        onClicked: () {},
      );

/*
    _fetch() async {
         final firebaseUser = await FirebaseAuth.instance.currentUser!;
         if(firebaseUser!=null) 
            await FirebaseFirestore.instance.collection('User').doc(firebaseUser.uid).get().then((ds){
              name = ds.data['Name'];
              print(name);
            } ).catchError((e){
              print(e);
            }
            
    }
    */
/*
  void getData()async{ //use a Async-await function to get the data
    DocumentSnapshot snapshot;
    final data =  await FirebaseFirestore.instance.collection("User").doc(uid).get(); //get the data
     snapshot = data;
  }

  Future getCurrentUserData() async{
    try {
      DocumentSnapshot ds = await userCollection.doc(uid).get();
      String  firstname = ds.get('FirstName');
      String lastname = ds.get('LastName');
      return [firstname,lastname];
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  */

  _fetch() async {
  
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null)
      print('ghgfs');
      await FirebaseFirestore.instance
          .collection('User')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        name = ds.data()!['Name'];
        surname = ds.data()!['Surname'];
        email = ds.data()!['Email'];
        print(name);
        print(firebaseUser.uid);
      }).catchError((e) {
        print(e);
      });
  }
}

  