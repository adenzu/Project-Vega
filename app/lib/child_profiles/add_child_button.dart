import 'package:app/database/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddChildButton extends StatelessWidget {
  final String text;

  const AddChildButton({
    Key? key,
    this.text = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController lastNameController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController routeIDController = TextEditingController();
    TextEditingController userIdController = TextEditingController();
    return Align(
      // width:300,
      // height: 100,
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        child: Icon(
          Icons.add,
          size: 18.0,
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(15),
          primary: Colors.orange, // <-- Button color
          onPrimary: Colors.white, // <-- Splash color
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PageView(
                children: [
                  AlertDialog(
                    scrollable: true,
                    title: const Text("Çocuk Ekle"),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: firstNameController,
                              decoration: const InputDecoration(
                                labelText: "Ad",
                                icon: Icon(Icons.person),
                              ),
                            ),
                            TextFormField(
                              controller: lastNameController,
                              decoration: const InputDecoration(
                                labelText: "Soyad",
                                icon: Icon(Icons.person),
                              ),
                            ),
                            TextFormField(
                              controller: routeIDController,
                              decoration: const InputDecoration(
                                labelText: 'Rota Kodu',
                                icon: Icon(Icons.car_rental),
                              ),
                            ),
                          ],
                        ),
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
                        child: const Text("Ekle"),
                        onPressed: () async {
                          if (firstNameController.text.isEmpty ||
                              lastNameController.text.isEmpty ||
                              routeIDController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Alanlar boş bırakılamaz");
                          } else if (!routeIDController.text
                              .contains(RegExp(r'^[R0-9]+$'))) {
                            Fluttertoast.showToast(
                                msg: "Hatalı rota kodu girdiniz");
                          } else if ((await FirebaseDatabase.instance
                                  .reference()
                                  .child("routes/${routeIDController.text}")
                                  .once())
                              .exists) {
                            Navigator.pop(context);
                            String childId = await generateChildId();
                            createChild(childId, {
                              'isReal': false,
                              'name': firstNameController.text,
                              'surname': lastNameController.text,
                              'info': 'Bilgi bulunmamakta.',
                              'parents': {
                                FirebaseAuth.instance.currentUser!.uid: true
                              },
                            });
                            addChild(childId);
                            requestChildRouteSub(
                                childId, routeIDController.text);
                            Fluttertoast.showToast(
                                msg: "Rota için abonelik isteği yollandı");
                          } else {
                            Fluttertoast.showToast(
                                msg: "Bu kodla bir rota bulunmuyor");
                          }
                        },
                      ),
                    ],
                  ),
                  AlertDialog(
                    title: const Text("Bağlan"),
                    content: TextFormField(
                      controller: userIdController,
                      decoration: const InputDecoration(
                        labelText: "Bağlantı kodu",
                        icon: Icon(Icons.vpn_key),
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
                        onPressed: () async {
                          if (userIdController.text.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Alanlar boş bırakılamaz");
                          } else if ((await FirebaseDatabase.instance
                                  .reference()
                                  .child(
                                      "publicUserIds/${userIdController.text}")
                                  .once())
                              .exists) {
                            Navigator.pop(context);
                            requestConnection(userIdController.text);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Böyle bir kullanıcı bulunmamakta");
                          }
                        },
                        child: const Text("Bağlan"),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
