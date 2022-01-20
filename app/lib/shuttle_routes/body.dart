import 'package:app/database/functions.dart';
import 'package:app/general/titled_rect_widget_button.dart';
import 'package:app/route/screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShuttleRoutesBody extends StatefulWidget {
  final String shuttleId;

  const ShuttleRoutesBody({Key? key, required this.shuttleId})
      : super(key: key);

  @override
  _ShuttleRoutesBodyState createState() => _ShuttleRoutesBodyState();
}

class _ShuttleRoutesBodyState extends State<ShuttleRoutesBody> {
  Map<String, bool> routeIds = {};
  TextEditingController routeNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final DatabaseReference routesRef = FirebaseDatabase.instance
        .reference()
        .child("shuttles/${widget.shuttleId}/routes");
    routesRef.onChildRemoved.listen((event) {
      setState(() {
        routeIds.clear();
      });
    });
    routesRef.onValue.listen((event) {
      setState(() {
        if (event.snapshot.exists) {
          routeIds = Map<String, bool>.from(event.snapshot.value);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        routeIds.isEmpty
            ? const Center(
                child: Text(
                  "Bu servise bağlı rota bulunmamaktadır.",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: routeIds.length,
                itemBuilder: (context, index) {
                  final String currId = routeIds.keys.elementAt(index);
                  return FutureBuilder(
                    future: FirebaseDatabase.instance
                        .reference()
                        .child("routes/$currId")
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
                                    const Icon(Icons.directions, size: 60),
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
                                color: Colors.pink,
                              ),
                              onLongPress: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RouteScreen(routeID: currId),
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("İşlem seç"),
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
                                            removeRoute(
                                                widget.shuttleId, currId);
                                          },
                                          child: const Text("Sil"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Seç"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        } else {
                          return const Text("Bilgi bulunmamakta.");
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
                  return AlertDialog(
                    scrollable: true,
                    title: const Text("Yeni oluştur"),
                    content: Column(
                      children: [
                        TextFormField(
                          controller: routeNameController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.sort_by_alpha),
                            label: Text("İsim"),
                          ),
                        )
                      ],
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
                        onPressed: () {
                          Navigator.pop(context);
                          addRoute(widget.shuttleId);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
