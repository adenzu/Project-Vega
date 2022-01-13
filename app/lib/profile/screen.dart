
import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:app/general/screens.dart';
import 'package:app/general/util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../profile/edit_profile_page.dart';
import '../profile/user_preferences.dart';
import '../profile/appbar_widget.dart';
import '../profile/button_widget.dart';
import '../profile/profile_widget.dart';
import '../profile/redirection_button.dart';
import 'package:image_picker/image_picker.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  String? name = null;
  String? surname = null;

   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   final imagePicker = ImagePicker();
   File? _image;

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
              imageProfile(),
              const SizedBox(height: 24),
              buildName(),
              const SizedBox(height: 24),
              Center(child: buildUpgradeButton()),
              const SizedBox(height: 48),
              FlatButton(
                child: Text("Update Info"),
                color: Colors.blue, 
                textColor: Colors.white,
                onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfilePage()),
                  );  },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: GestureDetector(
            onTap: () {
              _showPicker(context);
            },
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xffFDCF09),
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _image!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
          ),
      
    );
  }

  void _showPicker(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      }
    );
}

Future _imgFromCamera() async {
  final image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
}

Future _imgFromGallery() async {
  final image = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
}
/*
Future<String> uploadFile(File image) async
  {
    String downloadURL;
    String postId=DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance.ref().child("images").child("post_$postId.jpg");
    await ref.putFile(image);
    downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }
*/
/*
uploadToFirebase()async
{
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final String uid = _firebaseAuth.currentUser!.uid;
final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
final CollectionReference users = _firebaseFirestore.collection("User");
String url=await uploadFile(_image!); // this will upload the file and store url in the variable 'url'
await users.doc(uid).update({  //use update to update the doc fields.
'url':url
});
}
*/

  Widget buildName() => Column(
        children: [
          FutureBuilder(
            future: _fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Text("Loading data...Please wait");
              }
              return Text("$name $surname");
            },
          ),

          /*
          Text(
            FirebaseAuth.instance.currentUser!.displayName as String,
            
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          */
          const SizedBox(height: 4),
          Text(
            FirebaseAuth.instance.currentUser!.email as String,
            style: const TextStyle(color: Colors.grey),
          )
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
    final ref = FirebaseDatabase.instance.reference();
    User? cuser = await FirebaseAuth.instance.currentUser;

    return ref.child('users').child(cuser!.uid).once().then((DataSnapshot snap) {
      name = snap.value['name'].toString();
      surname = snap.value['surname'].toString();
    });
  }
}
