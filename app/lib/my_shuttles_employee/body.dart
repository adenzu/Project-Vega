import 'package:app/my_shuttles/sliding_panel.dart';
import 'package:app/shuttle_creation/shuttle_creation_screen1.dart';
import 'package:app/shuttle_creation/shuttle_creation_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../my_shuttles_map/screen.dart';
import '../shuttle_info/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/gradient_icon_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// test
class MyShuttleEmployeeScreenBody extends StatefulWidget {
  const MyShuttleEmployeeScreenBody({Key? key}) : super(key: key);

  @override
  State<MyShuttleEmployeeScreenBody> createState() =>
      _MyShuttleEmployeeScreenBodyState();
}

class _MyShuttleEmployeeScreenBodyState
    extends State<MyShuttleEmployeeScreenBody> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      children: <Widget>[
        SizedBox(
          height: size.height,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    width: size.width,
                    height: size.height,
                    child: const MyShuttleMap(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.02),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Colors.black87),
                        color: Colors.white70,
                      ),
                      padding: const EdgeInsets.fromLTRB(10.0, 4.0, 0.0, 4.0),
                      margin: EdgeInsets.symmetric(
                          vertical: size.height * 0.07, horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          GradientIconButton(
                            icon: const Icon(
                              Icons.directions_bus,
                              color: Colors.blue,
                            ),
                            iconSize: size.width * 0.1,
                            press: () {},
                          ),
                          Expanded(
                            flex: 1,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 10.0, 20.0, 10.0),
                                textStyle: const TextStyle(fontSize: 30),
                              ),
                              onPressed: null,
                              child: const Text("YBFL SERVIS",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),



                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
