import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/my_shuttles/sliding_panel.dart';
import 'package:app/shuttle_creation/shuttle_creation_screen1.dart';
import 'package:app/shuttle_creation/shuttle_creation_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../my_shuttles_map/screen.dart';
import '../shuttle_info/screen.dart';
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

  String dropdownValue = "Servis Yok";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SlidingUpPanel(
      controller: panelController,
      maxHeight: size.height * 0.19,
      minHeight: size.height * 0.04,
      parallaxEnabled: true,
      parallaxOffset: .5,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(30.0)),
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: size.width,
              height: size.height,
              child: const MyShuttleMap(),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.02),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: Colors.black87),
                      color: Colors.white70,
                    ),
                    padding: EdgeInsets.only(left: size.width * 0.15),
                    margin: EdgeInsets.symmetric(
                        vertical: size.height * 0.07, horizontal: 10.0),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.black87,
                      isExpanded: true,
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 8,
                      style: const TextStyle(color: Colors.blue),
                      underline: Container(
                        height: 2,
                        color: Colors.lightBlueAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>["Servis Yok", "YBFL Servis"]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: size.height * 0.096, left: size.width * 0.05),
              child: GradientIcon(
                icon: Icon(
                  Icons.directions_bus,
                  color: Colors.blue,
                  size: size.width * 0.08,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.white,
              ),
              margin: EdgeInsets.fromLTRB(
                  size.width * 0.83, size.height * 0.3, 0.0, 0.0),
              child: ShuttleCreationWidget(iconSize: size.width * 0.1),
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
              child: ShuttleCreationWidget(iconSize: size.width * 0.1),
            ),
          ],
        ),
      ),
      panelBuilder: (controller) => SlidingPanel(
        controller: controller,
        panelController: panelController,
      ),
    );
  }
}
