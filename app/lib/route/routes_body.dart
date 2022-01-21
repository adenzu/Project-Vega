import 'package:app/database/functions.dart';
import 'package:app/general/titled_rect_widget_button.dart';
import 'package:app/route/passenger_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RouteBody extends StatefulWidget {
  final String routeID;
  final bool editable;

  const RouteBody({Key? key, required this.routeID, this.editable = true})
      : super(key: key);

  @override
  _RouteBodyState createState() => _RouteBodyState();
}

class _RouteBodyState extends State<RouteBody> {
  late DatabaseReference routePassengersRef = FirebaseDatabase.instance
      .reference()
      .child("routes/${widget.routeID}/passengers");

  List<String> passengersIds = [];
  List<String> pendingPassengersIds = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final DatabaseReference pendingPassengerRef = FirebaseDatabase.instance
        .reference()
        .child("routes/${widget.routeID}/pendingUsers");

    pendingPassengerRef.onChildRemoved.listen((event) {
      setState(() {
        pendingPassengersIds.clear();
      });
    });

    pendingPassengerRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          pendingPassengersIds =
              Map<String, dynamic>.from(event.snapshot.value).keys.toList();
        });
      }
    });

    routePassengersRef.onChildRemoved.listen((event) {
      setState(() {
        passengersIds.clear();
      });
    });
    routePassengersRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          passengersIds =
              Map<String, dynamic>.from(event.snapshot.value).keys.toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return PageView(children: [
    //   passengersIds.isEmpty
    //       ? const Center(
    //           child: Text(
    //             "Rotaniz ....",
    //             style: TextStyle(fontSize: 30),
    //             textAlign: TextAlign.center,
    //           ),
    //         )
    //       : ListView.builder(
    //           itemCount: passengersIds.length,
    //           itemBuilder: (context, index) {
    //             String currId = passengersIds[index];
    //             bool isOn = false;
    //             int status = 0;
    //
    //             routePassengersRef
    //                 .child('$currId/status')
    //                 .onChildRemoved
    //                 .listen((event) {
    //               setState(() {
    //                 status = 0;
    //               });
    //             });
    //
    //             routePassengersRef
    //                 .child('$currId/status')
    //                 .onValue
    //                 .listen((event) {
    //               if (event.snapshot.exists) {
    //                 setState(() {
    //                   status = event.snapshot.value;
    //                 });
    //               }
    //             });
    //             return FutureBuilder(
    //               future: getUserData(userId: currId),
    //               builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
    //                 if (snapshot.hasData) {
    //                   if (snapshot.data!.exists) {
    //                     String name = snapshot.data!.value['name'];
    //                     String surname = snapshot.data!.value['surname'];
    //                     return PassengerCard(
    //                         name: '$name $surname',
    //                         status: status,
    //                         routeId: widget.routeID,
    //                         userId: currId);
    //                   } else {
    //                     return Text('Bilgi bulunmuyor.');
    //                   }
    //                 } else {
    //                   return Container(
    //                     padding: const EdgeInsets.all(40),
    //                     width: double.infinity,
    //                     height: 150,
    //                     child: const Center(
    //                       child: CircularProgressIndicator(),
    //                     ),
    //                   );
    //                 }
    //               },
    //             );
    //           },
    //         ),
    //
    // ]);

    List<Widget> listChildren = [];

    listChildren.addAll(
      List.generate(passengersIds.length, (index) {
        String currId = passengersIds[index];
        bool isOn = false;

        return FutureBuilder(
          future: getUserData(userId: currId),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.exists) {
                String name = snapshot.data!.value['name'];
                String surname = snapshot.data!.value['surname'];
                return PassengerCard(
                    name: '$name $surname',
                    routeId: widget.routeID,
                    userId: currId);
              } else {
                return const Text('Bilgi bulunmuyor.');
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
      }),
    );

    List<Widget> stackChildren = [
      ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        children: listChildren,
      )
    ];

    List<Widget> pageViewChildren = [
      Stack(
        children: stackChildren,
        alignment: Alignment.bottomRight,
      ),
    ];

    if (widget.editable) {
      pageViewChildren.add(pendingPassengersIds.isEmpty
          ? const Center(
              child: Text(
                "Bu rota için bekleyen yolcu isteği bulunmamaktadır.",
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: pendingPassengersIds.length,
              itemBuilder: (context, index) {
                String currId = pendingPassengersIds[index];
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
                                        rejectPassenger(widget.routeID, currId);
                                      },
                                      child: const Text("Reddet"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        acceptPassenger(widget.routeID, currId);
                                      },
                                      child: const Text("Kabul et"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          // onLongPress: () {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           ProfileScreen(userId: currId),
                          //     ),
                          //   );
                          // },
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
