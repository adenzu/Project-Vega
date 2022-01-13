import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}
class _MyPageState extends State<MyPage> {
  /// Variables
  File? _image;
  final imagePicker = ImagePicker();

  Future getImage() async{
    final image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
        _image == null ? Text("No Image Selected") : Image.file(_image!)),
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          backgroundColor: Colors.blue,
          child: Icon(Icons.camera_alt),
        ),
      );
            }

/*
  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
  */
}