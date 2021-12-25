//import 'dart:html';

import 'package:app/database/functions.dart';
import 'package:app/general/screens.dart';
import 'package:app/general/titled_rect_widget_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../child_profiles/add_child_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../child_profiles/enter_info.dart';

import 'redirection_button.dart';
import 'add_child_button.dart';

class ButtonsBlock extends StatefulWidget {
  const ButtonsBlock({Key? key}) : super(key: key);

  @override
  _ButtonsBlockState createState() => _ButtonsBlockState();
}

class _ButtonsBlockState extends State<ButtonsBlock> {
  final childrenRef = FirebaseDatabase.instance
      .reference()
      .child("users/" + FirebaseAuth.instance.currentUser!.uid + "/children");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final screenHeight = size.height;
    return Stack(
      children: [
        FutureBuilder(
            future: childrenRef.once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.exists) {
                  Map<String, bool> children =
                      Map<String, bool>.from(snapshot.data!.value);
                  List<String> childIds = children.keys.toList();

                  return ListView.builder(
                    itemCount: childIds.length,
                    itemBuilder: (context, i) {
                      return FutureBuilder(
                        future: FirebaseDatabase.instance
                            .reference()
                            .child("users/" + childIds[i])
                            .once(),
                        builder:
                            (context, AsyncSnapshot<DataSnapshot> snapshot) {
                          if (snapshot.hasData && snapshot.data!.exists) {
                            Map<String, dynamic> childInfo =
                                Map<String, dynamic>.from(snapshot.data!.value);
                            return Container(
                              padding: EdgeInsets.all(20),
                              child: TitledRectWidgetButton(
                                padding: EdgeInsets.all(20),
                                borderRadius: BorderRadius.circular(25),
                                alignment: Alignment.centerLeft,
                                title: Container(
                                  child: Text(childInfo['name'],
                                      style: TextStyle(fontSize: 50)),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  height: 150,
                                  color: Colors.blue,
                                ),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        title: Text("Child Information"),
                                        content: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Form(
                                            child: Column(
                                              children: <Widget>[
                                                Text(childInfo['name']),
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          ElevatedButton(
                                              child: Text("Edit"),
                                              onPressed: () async {}),
                                          ElevatedButton(
                                              child: Text("Delete Child"),
                                              onPressed: () async {
                                                for (var shuttleId
                                                    in childInfo['shuttles']) {
                                                  removeFromShuttle(
                                                      childIds[i], shuttleId);
                                                }
                                                removeChild(childIds[i]);
                                              })
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          }
                          return SizedBox();
                        },
                      );
                    },
                  );
                }
                return const Expanded(
                  child: Center(
                    child: Text(
                      "Bağlı profiliniz bulunmamaktadır.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
        Padding(
          padding: EdgeInsets.fromLTRB(
              size.width * 0.8, size.height * 0.2, 0.0, 0.0),
          child: const AddChildButton(),
        )
      ],
    );
  }
}

/*

showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Stack(
                      overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  child: Text("Submitß"),
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      _formKey.currentState.save();
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });

                */