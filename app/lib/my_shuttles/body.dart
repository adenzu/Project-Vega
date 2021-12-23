import '../my_shuttles_map/screen.dart';
import '../shuttle_info/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/gradient_icon_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyShuttleScreenBody extends StatefulWidget {
  const MyShuttleScreenBody({Key? key}) : super(key: key);

  @override
  State<MyShuttleScreenBody> createState() => _MyShuttleScreenBodyState();
}

class _MyShuttleScreenBodyState extends State<MyShuttleScreenBody> {
  int _status = 1;
  Color _statusContainerColor = Colors.green;
  Icon _statusIcon = const Icon(Icons.check, color: Colors.white);

  void _setStatus(int newStatus) {
    _status = newStatus;
    if (_status == -1) {
      _statusIcon = const Icon(Icons.close, color: Colors.white);
      _statusContainerColor = Colors.red;
    } else if (_status == 0) {
      _statusIcon = const Icon(Icons.watch_later, color: Colors.black);
      _statusContainerColor = Colors.yellowAccent;
    } else {
      _statusIcon = const Icon(Icons.check, color: Colors.white);
      _statusContainerColor = Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              Container(
                alignment: Alignment.topCenter,
                width: size.width,
                height: size.height * 0.80,
                child: MyShuttleMap(),
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
                child: IconButton(
                  iconSize: size.width * 0.1,
                  icon: const Icon(CupertinoIcons.refresh_circled_solid,
                      color: Colors.blue),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    size.width * 0.04, size.height * 0.63, 0.0, 0.0),
                width: size.width * 0.24,
                height: size.height * 0.09,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black87),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1.5),
                      ),
                      child: const Text("45",
                          style: TextStyle(fontSize: 25, color: Colors.black)),
                    ),
                    const SizedBox(width: 7.0),
                    Column(
                      children: const [
                        Text("100",
                            style:
                                TextStyle(fontSize: 25, color: Colors.orange)),
                        Text("KM/H",
                            style:
                                TextStyle(fontSize: 15, color: Colors.black)),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: size.height * 0.75),
                alignment: Alignment.topCenter,
                width: size.width,
                height: size.height * 0.25,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: Colors.black87),
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFD8D8D8),
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          size.width * 0.08, size.height * 0.04, 0.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.flag_outlined,
                              size: size.width * 0.1,
                              color: const Color(0xa84c56a8)),
                          Text(" --- ",
                              style: TextStyle(
                                  fontSize: size.width * 0.07,
                                  color: const Color(0xf5ac79cb))),
                          Icon(Icons.bus_alert,
                              size: size.width * 0.1,
                              color: const Color(0xa84c56a8)),
                          Text(": ",
                              style: TextStyle(
                                  fontSize: size.width * 0.07,
                                  color: const Color(0xa84c56a8))),
                          Text("5 min",
                              style: TextStyle(
                                  fontSize: size.width * 0.07,
                                  color: const Color(0xf5e76c2c))),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          size.width * 0.75, size.height * 0.03, 0.0, 0.0),
                      child: const Text(
                        "USAGE\nSTATUS",
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          size.width * 0.76, size.height * 0.1, 0.0, 0.0),
                      decoration: BoxDecoration(
                          color: _statusContainerColor,
                          borderRadius: BorderRadius.circular(30.0)),
                      child: IconButton(
                        icon: _statusIcon,
                        onPressed: () {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Shuttle Usage"),
                                  content:
                                      const Text("Will you use shuttle today?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _setStatus(-1);
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: const Text("No",
                                            style: TextStyle(
                                                color: Colors.white))),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _setStatus(0);
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: const Text("Late",
                                            style: TextStyle(
                                                color: Colors.white))),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _setStatus(1);
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: const Text("Yes",
                                            style: TextStyle(
                                                color: Colors.white))),
                                  ],
                                  elevation: 24.0,
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                );
                              });
                        },
                        iconSize: size.width * 0.1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          size.width * 0.08, size.height * 0.12, 0.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.bus_alert,
                              size: size.width * 0.1,
                              color: const Color(0xf56776f5)),
                          Text(" --- ",
                              style: TextStyle(
                                  fontSize: size.width * 0.07,
                                  color: const Color(0xf5ac79cb))),
                          Icon(Icons.flag,
                              size: size.width * 0.1,
                              color: const Color(0xf56776f5)),
                          Text(": ",
                              style: TextStyle(
                                  fontSize: size.width * 0.07,
                                  color: const Color(0xf56776f5))),
                          Text("45 min",
                              style: TextStyle(
                                  fontSize: size.width * 0.07,
                                  color: const Color(0xf5080887))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
