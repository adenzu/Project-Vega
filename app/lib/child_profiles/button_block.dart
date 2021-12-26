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
      setState(() {
        childrenIds =
            Map<String, bool>.from(event.snapshot.value).keys.toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final screenHeight = size.height;
    return Stack(
      children: [
        ListView.builder(
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
                            WidgetSpan(
                                child: Icon(
                                  Icons.account_circle,
                                  size: 20,
                                ),
                                alignment: PlaceholderAlignment.middle),
                            WidgetSpan(
                                child: Text(
                                  childInfo['name'],
                                  style: TextStyle(fontSize: 24),
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
                                    Navigator.of(context).pop();

                                    for (var shuttleId
                                        in Map<String, bool>.from(
                                                childInfo['shuttles'])
                                            .keys
                                            .toList()) {
                                      removeFromShuttle(currChildId, shuttleId);
                                    }
                                    removeChild(currChildId);
                                    deleteUser(currChildId);
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
                return const CircularProgressIndicator();
              },
            );
          },
        ),
        childrenIds.isNotEmpty
            ? const SizedBox()
            : const Center(
                child: Text(
                  "Bağlı profiliniz bulunmamaktadır.",
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
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