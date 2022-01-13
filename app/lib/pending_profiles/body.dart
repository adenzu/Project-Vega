import 'package:app/database/functions.dart';
import 'package:app/database/request.dart';
import 'package:app/general/titled_rect_widget_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PendingUsersBody extends StatefulWidget {
  const PendingUsersBody({Key? key}) : super(key: key);

  @override
  _PendingUsersBodyState createState() => _PendingUsersBodyState();
}

class _PendingUsersBodyState extends State<PendingUsersBody> {
  final sentUsersRef = FirebaseDatabase.instance
      .reference()
      .child("users/${FirebaseAuth.instance.currentUser!.uid}/sentUsers");
  final pendingUsersRef = FirebaseDatabase.instance
      .reference()
      .child("users/${FirebaseAuth.instance.currentUser!.uid}/pendingUsers");
  List<String> sentIds = [];
  List<String> pendingIds = [];
  TextEditingController userIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sentUsersRef.onChildRemoved.listen((event) {
      setState(() {
        sentIds.clear();
      });
    });
    sentUsersRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          sentIds = Map<String, int>.from(event.snapshot.value).keys.toList();
        });
      }
    });
    pendingUsersRef.onChildRemoved.listen((event) {
      setState(() {
        pendingIds.clear();
      });
    });
    pendingUsersRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          pendingIds =
              Map<String, int>.from(event.snapshot.value).keys.toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const double padding = 10;
    return PageView(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            sentIds.isEmpty
                ? const Center(
                    child: Text(
                      "Gönderilmiş bağlantı isteğiniz bulunmamaktadır.",
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemCount: sentIds.length,
                    itemBuilder: (context, i) {
                      String currId = sentIds[i];
                      return FutureBuilder(
                        future: FirebaseDatabase.instance
                            .reference()
                            .child("publicUserIds/$currId")
                            .once(),
                        builder:
                            (context, AsyncSnapshot<DataSnapshot> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.exists) {
                              return Container(
                                  padding: const EdgeInsets.all(padding),
                                  child: TitledRectWidgetButton(
                                    padding: const EdgeInsets.all(padding),
                                    borderRadius: BorderRadius.circular(25),
                                    alignment: Alignment.centerLeft,
                                    title: Text.rich(
                                      TextSpan(
                                        children: [
                                          const Icon(
                                            Icons.account_box,
                                            size: 60,
                                          ),
                                          Text(
                                            currId,
                                            style:
                                                const TextStyle(fontSize: 30),
                                          ),
                                        ]
                                            .map((e) => WidgetSpan(
                                                child: e,
                                                alignment: PlaceholderAlignment
                                                    .middle))
                                            .toList(),
                                      ),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 150,
                                      color: Colors.orange,
                                    ),
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title:
                                                const Text("İsteği iptal et?"),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Hayır"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  cancelConnectionRequest(
                                                      currId);
                                                },
                                                child: const Text("Evet"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ));
                            } else {
                              return const Text("Bilgi bulunmuyor.");
                            }
                          } else {
                            return Center(
                              child: Container(
                                padding: const EdgeInsets.all(40),
                                height: 190,
                                width: 190,
                                child: const CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("İstek yollayın"),
                        content: TextFormField(
                          controller: userIdController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.vpn_key),
                            label: Text("Kod"),
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
                                    msg: "Hatalı kullanıcı kodu girdiniz");
                              }
                            },
                            child: const Text("Ekle"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        pendingIds.isEmpty
            ? const Center(
                child: Text(
                  "Bekleyen bağlantı isteğiniz bulunmamaktadır.",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: pendingIds.length,
                itemBuilder: (context, i) {
                  String currId = pendingIds[i];
                  return FutureBuilder(
                    future: FirebaseDatabase.instance
                        .reference()
                        .child("users/$currId")
                        .once(),
                    builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.exists) {
                          String name = snapshot.data!.value['name'];
                          String surname = snapshot.data!.value['surname'];
                          return Container(
                              padding: const EdgeInsets.all(padding),
                              child: TitledRectWidgetButton(
                                padding: const EdgeInsets.all(padding),
                                borderRadius: BorderRadius.circular(25),
                                alignment: Alignment.centerLeft,
                                title: Text.rich(
                                  TextSpan(
                                    children: [
                                      const Icon(
                                        Icons.account_box,
                                        size: 60,
                                      ),
                                      Text(
                                        "$name $surname",
                                        style: const TextStyle(fontSize: 30),
                                      ),
                                    ]
                                        .map((e) => WidgetSpan(
                                            child: e,
                                            alignment:
                                                PlaceholderAlignment.middle))
                                        .toList(),
                                  ),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  color: Colors.purple,
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                            "Bağlantı isteğini kabul et?"),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              respondToConnectionRequest(
                                                  currId, Request.reject);
                                            },
                                            child: const Text("Reddet"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              respondToConnectionRequest(
                                                  currId, Request.accept);
                                            },
                                            child: const Text("Kabul et"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ));
                        } else {
                          return const Text("Bilgi bulunmuyor.");
                        }
                      } else {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.all(40),
                            height: 190,
                            width: 190,
                            child: const CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
      ],
    );
  }
}
