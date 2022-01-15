import 'package:app/database/functions.dart';
import 'package:app/general/titled_rect_widget_button.dart';
import 'package:app/shuttle/screen.dart';
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
  TextEditingController shuttlePlateController = TextEditingController();
  TextEditingController shuttleIdController = TextEditingController();
  TextEditingController shuttleSeatCountController = TextEditingController();
  final shuttleCreationFormKey = GlobalKey<FormState>();
  final shuttleConnectionFormKey = GlobalKey<FormState>();

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
                                      snapshot.data!.value["plate"],
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
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ShuttleScreen(
                                                  shuttleId: currId,
                                                ),
                                              ),
                                            );
                                          },
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
                        content: Form(
                          key: shuttleCreationFormKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: shuttlePlateController,
                                decoration: const InputDecoration(
                                  label: Text("Plaka"),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Bu alan boş bırakılamaz";
                                  } else {
                                    value =
                                        value.replaceAll(' ', '').toUpperCase();
                                    if (!value.contains(RegExp(
                                        r'^(0[1-9]|[1-7][0-9]|8[0-1])([A-Z]{1,3})([0-9]{2,4})$'))) {
                                      return "Uygun bir plaka giriniz";
                                    }
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: shuttleSeatCountController,
                                decoration: const InputDecoration(
                                  label: Text("Koltuk Sayısı"),
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return "null hatası";
                                  } else if (value.isEmpty) {
                                    return "Bu alan boş bırakılamaz";
                                  } else if (!value
                                      .contains(RegExp(r'^([1-9][0-9]*)$'))) {
                                    return "Pozitif sayı giriniz";
                                  }
                                  return null;
                                },
                              ),
                            ],
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
                            child: const Text("Ekle"),
                            onPressed: () async {
                              if (shuttleCreationFormKey.currentState!
                                  .validate()) {
                                String plate = shuttlePlateController.text
                                    .replaceAll(' ', '')
                                    .toUpperCase();
                                if (await checkPlateExists(plate)) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "Verilen plaka ile servis bulunmakta");
                                } else {
                                  Navigator.pop(context);
                                  addShuttle(
                                      plate,
                                      int.parse(
                                          shuttleSeatCountController.text));
                                }
                              }
                            },
                          ),
                        ],
                      ),
                      AlertDialog(
                        title: const Text("Bağlan"),
                        content: Form(
                          key: shuttleConnectionFormKey,
                          child: TextFormField(
                            controller: shuttleIdController,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.vpn_key),
                              label: Text("Kod"),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Bu alan boş bırakılamaz";
                              } else if (!value
                                  .contains(RegExp(r'^S[0-9]+$'))) {
                                return "Geçerli bir kod girin";
                              }
                              return null;
                            },
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
                            onPressed: () async {
                              if (shuttleConnectionFormKey.currentState!
                                  .validate()) {
                                if (await checkShuttleExists(
                                    shuttleIdController.text)) {
                                  Navigator.pop(context);
                                  requestShuttleEmployee(
                                      shuttleIdController.text);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Bu kodla bir servis bulunmamakta");
                                }
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
