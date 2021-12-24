//import 'dart:html';

import 'package:app/general/screens.dart';

import '../child_profiles/add_child_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../child_profiles/update_info.dart';

import 'redirection_button.dart';
import 'add_child_button.dart';

class ButtonsBlock extends StatelessWidget {
  const ButtonsBlock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    return Stack(
      // alignment: AlignmentDirectional.bottomStart,
      children: [
        Column(
          children: const [
            //   const Expanded(child: SizedBox()),
            RedirectionButton(
              text: "Oğuz Acar",
              screenName: ScreenNames.childProfiles,
            ),
            SizedBox(
              height: 15,
              width: double.maxFinite,
            ),
            RedirectionButton(
              text: "Ahmet Mutlu",
              screenName: ScreenNames.childProfiles,
            ),
            SizedBox(
              height: 15,
              width: double.maxFinite,
            ),
            RedirectionButton(
              text: "Mehmet Yazıcı",
              screenName: ScreenNames.childProfiles,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              size.width * 0.8, size.height * 0.1, 0.0, 0.0),
          child: const AddChildButton(
            text: "",
            screenName: ScreenNames.childUpdate,
          ),
        )
      ],
    );
    //

    //
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