import 'package:app/database/functions.dart';
import 'package:app/general/titled_rect_widget_button.dart';
import 'package:app/general/util.dart';
import 'package:app/shuttle_routes/screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmployeeShuttlesBody extends StatefulWidget {
  const EmployeeShuttlesBody({Key? key}) : super(key: key);

  @override
  _EmployeeShuttlesBodyState createState() => _EmployeeShuttlesBodyState();
}

class _EmployeeShuttlesBodyState extends State<EmployeeShuttlesBody> {
  final DatabaseReference shuttlesRef = FirebaseDatabase.instance
      .reference()
      .child("employees/${FirebaseAuth.instance.currentUser!.uid}/shuttles");
  List<String> shuttleIds = [];
  TextEditingController shuttleNameController = TextEditingController();
  TextEditingController shuttleIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    shuttlesRef.onChildRemoved.listen((event) {
      setState(() {
        shuttleIds.clear();
      });
    });
    shuttlesRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          shuttleIds =
              Map<String, bool>.from(event.snapshot.value).keys.toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        shuttleIds.isEmpty
            ? const Center(
                child: Text(
                  "Görevlisi olduğunuz bir servis bulunmamaktadır.",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: shuttleIds.length,
                itemBuilder: (context, index) {
                  String currId = shuttleIds[index];
                  return FutureBuilder(
                    future: FirebaseDatabase.instance
                        .reference()
                        .child("shuttles/$currId")
                        .once(),
                    builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.exists) {
                          return Container(
                            padding: const EdgeInsets.all(20),
                            child: TitledRectWidgetButton(
                              padding: const EdgeInsets.all(20),
                              borderRadius: BorderRadius.circular(25),
                              alignment: Alignment.centerLeft,
                              title: Text.rich(
                                TextSpan(
                                  children: [
                                    const Icon(
                                      Icons.airport_shuttle,
                                      size: 60,
                                    ),
                                    Text(
                                      currId,
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
                                color: Colors.red,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ShuttleRoutesScreen(shuttleId: currId),
                                  ),
                                );
                              },
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("İşlem seç"),
                                      actions: [
                                        ElevatedButton(
                                          child: const Text("İptal"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ElevatedButton(
                                          child: const Text("Düzenle"),
                                          onPressed: () {},
                                        ),
                                        ElevatedButton(
                                          child: const Text("Ayrıl"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            leaveShuttle(currId);
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        } else {
                          return const Text("Bilgi bulunmuyor.");
                        }
                      } else {
                        return Container(
                          padding: const EdgeInsets.all(40),
                          width: double.infinity,
                          height: 150,
                          child: const Center(
                            child: CircularProgressIndicator(),
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
                  return PageView(
                    children: [
                      AlertDialog(
                        scrollable: true,
                        title: const Text("Yeni oluştur"),
                        content: Column(
                          children: [
                            TextFormField(
                              controller: shuttleNameController,
                              decoration: const InputDecoration(
                                label: Text("İsim"),
                                icon: Icon(Icons.sort_by_alpha),
                              ),
                            )
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            child: const Text("İptal"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                            child: const Text("Ekle"),
                            onPressed: () {
                              if (shuttleNameController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Alanlar boş bırakılamaz");
                              } else {
                                Navigator.pop(context);
                                addShuttle();
                              }
                            },
                          ),
                        ],
                      ),
                      AlertDialog(
                        title: const Text("Bağlan"),
                        content: TextFormField(
                          controller: shuttleIdController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.vpn_key),
                            label: Text("Kod"),
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            child: const Text("İptal"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                            child: const Text("Bağlan"),
                            onPressed: () {
                              if (shuttleNameController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Alanlar boş bırakılamaz");
                              } else {
                                Navigator.pop(context);
                                addShuttle();
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
