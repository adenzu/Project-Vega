import 'package:app/database/functions.dart';
import 'package:app/general/titled_rect_widget_button.dart';
import 'package:app/profile/screen.dart';
import 'package:app/route/screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShuttleBody extends StatefulWidget {
  final String shuttleId;
  final DataSnapshot? shuttleData;
  final bool editable;

  const ShuttleBody({
    Key? key,
    required this.shuttleId,
    this.shuttleData,
    this.editable = false,
  }) : super(key: key);

  @override
  _ShuttleBodyState createState() => _ShuttleBodyState();
}

class _ShuttleBodyState extends State<ShuttleBody> {
  late DatabaseReference shuttleRef = FirebaseDatabase.instance
      .reference()
      .child("shuttles/${widget.shuttleId}");
  late DataSnapshot shuttleData;
  List<String> pendingEmployeeIds = [];
  List<String> employeeIds = [];
  final shuttleInfoController = TextEditingController();
  late String shuttleInfo = "Yükleniyor...";
  String? currRouteId;

  void settleShuttleData() async {
    shuttleData = widget.shuttleData ??
        (await FirebaseDatabase.instance
                .reference()
                .child("shuttles/${widget.shuttleId}")
                .once())
            .value;
  }

  @override
  void initState() {
    super.initState();
    settleShuttleData();

    DatabaseReference pendingEmployeesRef =
        shuttleRef.child("pendingEmployees");
    DatabaseReference employeesRef = shuttleRef.child("employees");
    DatabaseReference infoRef = shuttleRef.child("info");
    DatabaseReference currRouteRef = shuttleRef.child("currentRoute");

    pendingEmployeesRef.onChildRemoved.listen((event) {
      setState(() {
        pendingEmployeeIds.clear();
      });
    });

    pendingEmployeesRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          pendingEmployeeIds =
              Map<String, dynamic>.from(event.snapshot.value).keys.toList();
        });
      }
    });

    employeesRef.onChildRemoved.listen((event) {
      setState(() {
        employeeIds.clear();
      });
    });

    employeesRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          employeeIds =
              Map<String, dynamic>.from(event.snapshot.value).keys.toList();
        });
      }
    });

    shuttleRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          shuttleData = event.snapshot;
        });
      }
    });

    infoRef.onChildRemoved.listen((event) {
      setState(() {
        shuttleInfo = "Bilgi bulunmamakta.";
      });
    });

    infoRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          shuttleInfo = event.snapshot.value;
        });
      }
    });

    currRouteRef.onChildRemoved.listen((event) {
      setState(() {
        currRouteId = null;
      });
    });

    currRouteRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          currRouteId = event.snapshot.value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> employees =
        (Map<String, bool>.from(shuttleData.value['employees'])).keys.toList();

    List<Widget> listChildren = [
      const Text(
        "Servis Bilgisi",
        style: TextStyle(fontSize: 30),
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(5, 0, 0, 20),
        child: Text(
          shuttleInfo,
        ),
      ),
    ];

    if (currRouteId != null) {
      listChildren.add(
        TitledRectWidgetButton(
          title: Text.rich(
            TextSpan(
              children: [
                const WidgetSpan(
                  child: Icon(
                    Icons.airport_shuttle,
                    size: 60,
                  ),
                  alignment: PlaceholderAlignment.middle,
                ),
                WidgetSpan(
                  child: Text(
                    currRouteId!,
                    style: const TextStyle(fontSize: 30),
                  ),
                  alignment: PlaceholderAlignment.middle,
                ),
              ],
            ),
          ),
          child: Container(
              width: double.infinity, height: 150, color: Colors.green),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RouteScreen(
                routeID: currRouteId!,
              ),
            ),
          ),
        ),
      );
    }

    listChildren.add(
      const Text(
        "Görevliler",
        style: TextStyle(fontSize: 30),
      ),
    );

    listChildren.addAll(
      List.generate(employees.length, (index) {
        String currId = employees[index];
        return FutureBuilder(
          future: FirebaseDatabase.instance
              .reference()
              .child("users/$currId")
              .once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.exists) {
                String name = snapshot.data!.value["name"];
                String surname = snapshot.data!.value["surname"];
                return Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TitledRectWidgetButton(
                    borderRadius: BorderRadius.circular(25),
                    title: Text.rich(
                      TextSpan(
                        children: [
                          const Icon(
                            Icons.account_circle,
                            size: 60,
                          ),
                          Text(
                            "$name $surname",
                            style: const TextStyle(fontSize: 30),
                          ),
                        ]
                            .map((e) => WidgetSpan(
                                child: e,
                                alignment: PlaceholderAlignment.middle))
                            .toList(),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.blue,
                    ),
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("$name $surname"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Geri"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              removeEmployee(widget.shuttleId, currId);
                            },
                            child: const Text("Çıkart"),
                          ),
                        ],
                      ),
                    ),
                    onLongPress: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                          userId: currId,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const Text("Bilgi bulunmamakta");
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        );
      }),
    );

    List<Widget> stackChildren = [
      ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        children: listChildren,
      )
    ];

    if (widget.editable) {
      stackChildren.add(
        Container(
          padding: const EdgeInsets.all(15),
          child: FloatingActionButton(
            child: const Icon(Icons.edit),
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Servis Bilgisi Ekle"),
                  content: TextFormField(
                    controller: shuttleInfoController,
                    keyboardType: TextInputType.multiline,
                    decoration:
                        const InputDecoration(label: Text("Servis Bilgisi")),
                    maxLines: null,
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
                        Navigator.pop(context);
                        setShuttleInfo(
                            widget.shuttleId, shuttleInfoController.text);
                      },
                      child: const Text("Kaydet"),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );
    }
    List<Widget> pageViewChildren = [
      Stack(
        children: stackChildren,
        alignment: Alignment.bottomRight,
      ),
    ];

    if (widget.editable) {
      pageViewChildren.add(pendingEmployeeIds.isEmpty
          ? const Center(
              child: Text(
                "Bu servis için bekleyen görevli isteği bulunmamakta",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: pendingEmployeeIds.length,
              itemBuilder: (context, index) {
                String currId = pendingEmployeeIds[index];
                return FutureBuilder(
                  future: getUserData(userId: currId),
                  builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      DataSnapshot userData = snapshot.data!;
                      if (userData.exists) {
                        String userName = userData.value['name'];
                        String userSurname = userData.value['surname'];
                        return TitledRectWidgetButton(
                          borderRadius: BorderRadius.circular(25),
                          title: Text.rich(
                            TextSpan(
                              children: [
                                const Icon(
                                  Icons.account_circle,
                                  size: 60,
                                ),
                                Text(
                                  "$userName $userSurname",
                                  style: const TextStyle(fontSize: 30),
                                ),
                              ]
                                  .map(
                                    (e) => WidgetSpan(
                                        child: e,
                                        alignment: PlaceholderAlignment.middle),
                                  )
                                  .toList(),
                            ),
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            color: Colors.blue,
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("$userName $userSurname"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("İptal"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        rejectEmployee(
                                            widget.shuttleId, currId);
                                      },
                                      child: const Text("Reddet"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        acceptEmployee(
                                            widget.shuttleId, currId);
                                      },
                                      child: const Text("Kabul et"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          onLongPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen(userId: currId),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Text("Bilgi bulunmamakta");
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                );
              },
            ));
    }
    return PageView(
      children: pageViewChildren,
    );
  }
}
