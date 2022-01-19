import 'dart:io';
import 'dart:typed_data';

import 'package:app/database/functions.dart';
import 'package:app/general/titled_rect_widget_button.dart';
import 'package:app/general/util.dart';
import 'package:app/profile/screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileBody extends StatefulWidget {
  final String userId;
  final bool editable;
  final bool canSeeParents;

  const ProfileBody({
    Key? key,
    required this.userId,
    this.editable = false,
    this.canSeeParents = false,
  }) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  late DatabaseReference userRef =
      FirebaseDatabase().reference().child("users/${widget.userId}");
  // ignore: FirebaseException
  late Reference profilePictureRef =
      FirebaseStorage.instance.ref("profilePictures/${widget.userId}");
  late String userName = "";
  late String userSurname = "";
  late String userInfo = "Bilgi bulunmamakta.";
  final userUpdateFormKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final userSurnameController = TextEditingController();
  final userInfoController = TextEditingController();
  List<String> parentIds = [];
  String? profilePictureURL;
  Image? profilePicture;
  final double profilePictureRadius = 60;

  @override
  void initState() {
    super.initState();

    DatabaseReference userNameRef = userRef.child("name");
    DatabaseReference userSurnameRef = userRef.child("surname");
    DatabaseReference userInfoRef = userRef.child("info");

    userNameRef.onChildRemoved.listen((event) {
      setState(() {
        userName = "";
      });
    });

    userNameRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          userName = event.snapshot.value;
        });
      }
    });

    userSurnameRef.onChildRemoved.listen((event) {
      setState(() {
        userSurname = "";
      });
    });

    userSurnameRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          userSurname = event.snapshot.value;
        });
      }
    });

    userInfoRef.onChildRemoved.listen((event) {
      setState(() {
        userInfo = "Bilgi bulunmamakta.";
      });
    });

    userInfoRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          userInfo = event.snapshot.value;
        });
      }
    });

    if (widget.canSeeParents) {
      DatabaseReference userParentsRef = userRef.child("parents");

      userParentsRef.onChildRemoved.listen((event) {
        setState(() {
          parentIds.clear();
        });
      });

      userParentsRef.onValue.listen((event) {
        if (event.snapshot.exists) {
          setState(() {
            parentIds =
                Map<String, dynamic>.from(event.snapshot.value).keys.toList();
          });
        }
      });
    }

    getProfilePicture();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listViewChildren = [
      CircleAvatar(
        radius: profilePictureRadius,
        backgroundColor: const Color(0xffFDCF09),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            profilePicture == null
                ? Container(
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.grey[800],
                      size: profilePictureRadius * 2,
                    ),
                    width: profilePictureRadius * 2,
                    height: profilePictureRadius * 2,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  )
                : ClipOval(
                    child: profilePicture,
                  ),
            widget.editable
                ? Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _showPicker,
                      padding: const EdgeInsets.all(0),
                      icon: const Icon(Icons.edit),
                      color: Colors.white,
                      iconSize: 20,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      Text(
        "$userName $userSurname",
        style: const TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      FutureBuilder(
        future: getUserData(userId: widget.userId),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.exists) {
              bool isUserReal = snapshot.data!.value["isReal"];
              String userId =
                  isUserReal ? snapshot.data!.value["publicId"] : widget.userId;
              return Text(
                "Kod: $userId",
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              );
            } else {
              return const Text(
                "Bilgi bulunmamakta",
                textAlign: TextAlign.center,
              );
            }
          } else {
            return const Text(
              "Yükleniyor...",
              textAlign: TextAlign.center,
            );
          }
        },
      ),
      const SizedBox(
        height: 25,
      ),
      const Text(
        "Kullanıcı Bilgisi",
        style: TextStyle(fontSize: 25),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 20),
        child: Text(userInfo),
      ),
    ];

    if (widget.canSeeParents) {
      listViewChildren.add(
        Container(
          padding: const EdgeInsets.only(bottom: 5),
          child: const Text(
            "Ebeveynler",
            style: TextStyle(fontSize: 25),
          ),
        ),
      );

      if (parentIds.isEmpty) {
        listViewChildren.add(const Text("Ebeveyn bulunmamakta"));
      } else {
        listViewChildren.addAll(
          parentIds.map(
            (parentId) => TitledRectWidgetButton(
              borderRadius: BorderRadius.circular(25),
              title: Text.rich(
                TextSpan(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 60,
                    ),
                    FutureBuilder(
                      future: getUserData(userId: parentId),
                      builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.exists) {
                            String parentName = snapshot.data!.value["name"];
                            String parentSurname =
                                snapshot.data!.value["surname"];
                            return Text(
                              "$parentName $parentSurname",
                              style: const TextStyle(fontSize: 30),
                            );
                          } else {
                            return const Text(
                              "Bilgi bulunmuyor",
                              style: TextStyle(fontSize: 30),
                            );
                          }
                        } else {
                          return const Text(
                            "Yükleniyor...",
                            style: TextStyle(fontSize: 30),
                          );
                        }
                      },
                    )
                  ]
                      .map(
                        (e) => WidgetSpan(
                          child: e,
                          alignment: PlaceholderAlignment.middle,
                        ),
                      )
                      .toList(),
                ),
              ),
              child: Container(
                width: double.infinity,
                height: 150,
                color: Colors.blue,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(userId: parentId),
                ),
              ),
            ),
          ),
        );
      }
    }

    List<Widget> stackChildren = [
      ListView(
        padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
        children: listViewChildren,
      ),
    ];

    if (widget.editable) {
      stackChildren.add(
        Container(
          padding: const EdgeInsets.all(15),
          child: FloatingActionButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                userInfoController.text = userInfo;
                return AlertDialog(
                  scrollable: true,
                  title: const Text("Profili Güncelle"),
                  content: Form(
                    key: userUpdateFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: userNameController,
                          decoration: const InputDecoration(label: Text("Ad")),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Alan boş bırakılamaz";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: userSurnameController,
                          decoration:
                              const InputDecoration(label: Text("Soyad")),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Alan boş bırakılamaz";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: userInfoController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: const InputDecoration(
                            label: Text(
                              "Kullanıcı Bilgisi",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("İptal"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (userUpdateFormKey.currentState!.validate()) {
                          Navigator.pop(context);
                          userRef.child("name").set(userNameController.text);
                          userRef
                              .child("surname")
                              .set(userSurnameController.text);
                          userRef.child("info").set(userInfoController.text);
                        }
                      },
                      child: const Text("Kaydet"),
                    ),
                  ],
                );
              },
            ),
            child: const Icon(Icons.edit),
          ),
        ),
      );
    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: stackChildren,
    );
  }

  Future _imgFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      final profilePictureFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        cropStyle: CropStyle.circle,
      );
      setState(() {
        profilePicture = Image.file(
          profilePictureFile!,
          width: profilePictureRadius * 2,
          height: profilePictureRadius * 2,
        );
      });
      await profilePictureRef.putFile(profilePictureFile!);
    }
  }

  Future _imgFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final profilePictureFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        cropStyle: CropStyle.circle,
      );
      setState(() {
        profilePicture = Image.file(profilePictureFile!,
            width: profilePictureRadius * 2, height: profilePictureRadius * 2);
      });
      await profilePictureRef.putFile(profilePictureFile!);
    }
  }

  void _showPicker() {
    showTightModalBottomSheet(context: context, children: [
      ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Photo Library'),
          onTap: () {
            Navigator.pop(context);
            _imgFromGallery();
          }),
      ListTile(
          leading: const Icon(Icons.photo_camera),
          title: const Text('Camera'),
          onTap: () {
            Navigator.pop(context);
            _imgFromCamera();
          }),
    ]);
  }

  Future<void> getProfilePicture() async {
    if (profilePictureURL != null) {
      setState(() {
        profilePicture = Image.network(profilePictureURL!,
            width: profilePictureRadius * 2, height: profilePictureRadius * 2);
      });
    } else if (profilePictureRef != FirebaseStorage.instance.ref()) {
      profilePictureURL =
          await profilePictureRef.getDownloadURL().then((value) {
        setState(() {
          profilePicture = Image.network(value,
              width: profilePictureRadius * 2,
              height: profilePictureRadius * 2);
        });
        return value;
      }, onError: (value) => null);
    }
  }
}
