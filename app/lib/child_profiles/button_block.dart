//import 'dart:html';

import 'package:app/database/functions.dart';
import 'package:app/general/titled_rect_widget_button.dart';
import 'package:app/profile/screen.dart';
import 'package:app/route_connection/screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../child_profiles/add_child_button.dart';
import 'package:flutter/material.dart';
import 'add_child_button.dart';

class ButtonsBlock extends StatefulWidget {
  const ButtonsBlock({Key? key}) : super(key: key);

  @override
  _ButtonsBlockState createState() => _ButtonsBlockState();
}

class _ButtonsBlockState extends State<ButtonsBlock> {
  final childrenRef = FirebaseDatabase.instance
      .reference()
      .child("users/${FirebaseAuth.instance.currentUser!.uid}/children");
  List<String> childrenIds = [];

  @override
  void initState() {
    super.initState();
    childrenRef.onChildRemoved.listen((event) {
      setState(() {
        childrenIds.clear();
      });
    });
    childrenRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          childrenIds =
              Map<String, bool>.from(event.snapshot.value).keys.toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        childrenIds.isEmpty
            ? const Center(
                child: Text(
                  "Çocuğunuz bulunmamaktadır.",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              )
            : ListView.builder(
                itemCount: childrenIds.length,
                itemBuilder: (context, i) {
                  String currChildId = childrenIds[i];
                  return FutureBuilder(
                    future: FirebaseDatabase.instance
                        .reference()
                        .child("users/" + currChildId)
                        .once(),
                    builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                      if (snapshot.hasData && snapshot.data!.exists) {
                        Map<String, dynamic> childInfo =
                            Map<String, dynamic>.from(snapshot.data!.value);
                        return Container(
                          padding: EdgeInsets.all(20),
                          child: TitledRectWidgetButton(
                            padding: EdgeInsets.all(20),
                            borderRadius: BorderRadius.circular(25),
                            alignment: Alignment.centerLeft,
                            title: Text.rich(
                              TextSpan(
                                children: [
                                  const WidgetSpan(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white54,
                                        size: 100.0,
                                      ),
                                      alignment: PlaceholderAlignment.middle),
                                  WidgetSpan(
                                      child: Text(
                                        childInfo['name'] + " \n",
                                        style: DefaultTextStyle.of(context)
                                            .style
                                            .apply(
                                                fontSizeFactor: 2.0,
                                                color: Colors.white),
                                      ),
                                      alignment: PlaceholderAlignment.middle),
                                  WidgetSpan(
                                      child: Text(
                                        childInfo['surname'],
                                        style: DefaultTextStyle.of(context)
                                            .style
                                            .apply(
                                                fontSizeFactor: 1.0,
                                                color: Colors.white70),
                                      ),
                                      alignment: PlaceholderAlignment.middle)
                                ],
                              ),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              color: Colors.blue,
                            ),
                            onLongPress: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(
                                  userId: currChildId,
                                  editable: true,
                                  canSeeParents: true,
                                ),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    scrollable: true,
                                    title: Text(
                                        "${childInfo['name']} ${childInfo['surname']}"),
                                    actions: [
                                      ElevatedButton(
                                          child: const Text("İptal"),
                                          onPressed: () =>
                                              Navigator.pop(context)),
                                      ElevatedButton(
                                        child: const Text("Rotaya Ekle"),
                                        onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RouteConnectionScreen(
                                              userId: currChildId,
                                            ),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        child: const Text("Sil"),
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          if (childInfo['routes'] != null) {
                                            for (var shuttleId
                                                in Map<String, bool>.from(
                                                        childInfo['routes'])
                                                    .keys
                                                    .toList()) {
                                              childUnsubRoute(
                                                  currChildId, shuttleId);
                                            }
                                          }
                                          removeChild(currChildId);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        );
                      }
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.all(40),
                          height: 190,
                          width: 190,
                          child: const CircularProgressIndicator(),
                        ),
                      );
                    },
                  );
                },
              ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              size.width * 0.7, size.height * 0.2, 0.0, 0.0),
          child: const AddChildButton(),
        )
      ],
    );
  }
}
