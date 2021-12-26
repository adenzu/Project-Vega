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
                      String currChildId = childIds[i];
                      return FutureBuilder(
                        future: FirebaseDatabase.instance
                            .reference()
                            .child("users/" + currChildId)
                            .once(),
                        builder:
                            (context, AsyncSnapshot<DataSnapshot> snapshot) {
                          if (snapshot.hasData && snapshot.data!.exists) {
                            Map<String, dynamic> childInfo =
                                Map<String, dynamic>.from(snapshot.data!.value);
                            return Container(
                              padding: EdgeInsets.all(15),
                              child: TitledRectWidgetButton(
                                padding: EdgeInsets.all(15),
                                borderRadius: BorderRadius.circular(25),
                                alignment: Alignment.centerLeft,
                                title: Text.rich(TextSpan(children: [
                                  WidgetSpan(
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
                                ])),
                                //  Container(
                                //   child: Text(childInfo['name'],
                                //       style: TextStyle(fontSize: 50)),
                                // ),
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
                                                Text.rich(TextSpan(children: [
                                                  WidgetSpan(
                                                      child: Text(
                                                        childInfo['name'] +
                                                            " " +
                                                            childInfo[
                                                                'surname'] +
                                                            "\n",
                                                        style: DefaultTextStyle
                                                                .of(context)
                                                            .style
                                                            .apply(
                                                                fontSizeFactor:
                                                                    1.0,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                      alignment:
                                                          PlaceholderAlignment
                                                              .middle),
                                                ])),
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
                                                removeFromShuttle(
                                                    currChildId, shuttleId);
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
              size.width * 0.7, size.height * 0.2, 0.0, 0.0),
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