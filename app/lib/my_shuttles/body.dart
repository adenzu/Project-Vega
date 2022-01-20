import 'package:app/database/functions.dart';
import 'package:app/shuttle/screen.dart';
import 'package:firebase_database/firebase_database.dart';
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

  bool _showInfo = false;
  int _itemNum = -1;

  late Future userRouteFuture;

  _getUserRoute() async {
    List<String>? a = await getUserRoutes();

    setState(() {
      if (a!.isEmpty == true) {
        _showInfo = false;
        _itemNum = 0;
      } else {
        _userRoute = a[0];
        _itemNum = 1;
        _showInfo = true;
      }
    });
    return a;
  }

  String _userRoute = "s";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userRouteFuture = _getUserRoute();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
        future: userRouteFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (_itemNum == -1) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (_itemNum == 0) {
            return const Center(
              child: Text(
                "Kayıtlı Rota Bulunamadı",
                style: TextStyle(fontSize: 25, color: Colors.blue),
              ),
            );
          }
          // tek servise göre yap
          else {
            return SlidingUpPanel(
              controller: panelController,
              maxHeight: size.height * 0.19,
              minHeight: size.height * 0.04,
              parallaxEnabled: true,
              parallaxOffset: .5,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30.0)),
              body: SizedBox(
                height: size.height,
                width: double.infinity,
                child: Stack(
                  children: [
                    FutureBuilder(
                        future: FirebaseDatabase.instance
                            .reference()
                            .child("routes/$_userRoute/shuttleId")
                            .once(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return  Container(
                              alignment: Alignment.topCenter,
                              width: size.width,
                              height: size.height,
                                  child: MyShuttleMap(shuttleId: snapshot.data.value),
                            );
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
                        }),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.02),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(width: 1, color: Colors.black87),
                              color: Colors.white70,
                            ),
                            padding: EdgeInsets.only(left: size.width * 0.15),
                            margin: EdgeInsets.symmetric(
                                vertical: size.height * 0.07, horizontal: 10.0),
                            child: DropdownButton<String>(
                              dropdownColor: Colors.black87,
                              isExpanded: true,
                              value: _userRoute,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 8,
                              style: const TextStyle(color: Colors.blue),
                              underline: Container(
                                height: 2,
                                color: Colors.lightBlueAccent,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _userRoute = newValue!;
                                });
                              },
                              items: snapshot.data!
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
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
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(30.0),
                    //     color: Colors.white,
                    //   ),
                    //   margin: EdgeInsets.fromLTRB(
                    //       size.width * 0.83, size.height * 0.3, 0.0, 0.0),
                    //   child: ShuttleCreationWidget(iconSize: size.width * 0.1),
                    // ),

                    Visibility(
                      visible: _showInfo,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.fromLTRB(
                            size.width * 0.83, size.height * 0.2, 0.0, 0.0),
                        child: FutureBuilder(
                            future: FirebaseDatabase.instance
                                .reference()
                                .child("routes/$_userRoute/shuttleId")
                                .once(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return IconButton(
                                  iconSize: size.width * 0.1,
                                  icon: const Icon(
                                    Icons.info_outline_rounded,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShuttleScreen(
                                            shuttleId: snapshot.data.value),
                                      )),
                                );
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
                            }),
                      ),
                    ),
                  ],
                ),
              ),
              panelBuilder: (controller) => SlidingPanel(
                controller: controller,
                panelController: panelController,
                isRoute: _showInfo,
                routeID: _userRoute,
              ),
            );
          }
        });
  }
}
