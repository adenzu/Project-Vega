import 'package:app/my_shuttles/sliding_panel.dart';
//import 'package:app/shuttle_creation/shuttle_creation_screen1.dart';
//import 'package:app/shuttle_creation/shuttle_creation_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../my_shuttles_map/screen.dart';
import '../shuttle_info/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/gradient_icon_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


// test
class MyShuttleScreenBody extends StatefulWidget {
  const MyShuttleScreenBody({Key? key}) : super(key: key);

  @override
  State<MyShuttleScreenBody> createState() => _MyShuttleScreenBodyState();
}

class _MyShuttleScreenBodyState extends State<MyShuttleScreenBody> {
  final panelController = PanelController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SlidingUpPanel(
      controller: panelController,
      maxHeight: size.height*0.19,
      minHeight: size.height*0.04,
      parallaxEnabled: true,
      parallaxOffset: .5,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
      body: SizedBox(
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
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.fromLTRB(
                      size.width * 0.83, size.height * 0.2, 0.0, 0.0),
                  child: IconButton(
                    iconSize: size.width * 0.1,
                    icon: const Icon(
                      Icons.info_outline_rounded,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const ShuttleInfoScreen(shuttleID: 0)),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.fromLTRB(
                      size.width * 0.83, size.height * 0.3, 0.0, 0.0),
                 // child: ShuttleCreationWidget(iconSize: size.width *0.1),
                ),
              ],
            ),
          ],
        ),
      ),
      panelBuilder: (controller) => SlidingPanel(controller: controller,panelController: panelController,),
    );
  }
}
