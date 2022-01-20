import 'package:app/general/util.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingPanel extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;
  final bool isRoute;
  final String routeID;

  const SlidingPanel(
      {Key? key,
      required this.controller,
      required this.panelController,
      required this.isRoute,
      required this.routeID})
      : super(key: key);

  @override
  State<SlidingPanel> createState() => _SlidingPanelState();
}

class _SlidingPanelState extends State<SlidingPanel> {
  String _speedShuttle = "";
  String _estimatedTime = "";
  String _speedLimit = "";
  String _usageMessage = "Servisi kullanacağım.";

  int _status = 1;
  Color _statusContainerColor = Colors.green;
  Icon _statusIcon = const Icon(Icons.check, color: Colors.white);

  @override
  void initState() {
    super.initState();

    final DatabaseReference statusRef = FirebaseDatabase.instance
        .reference()
        .child("routes/${widget.routeID}/passengers/${getUserId()}/status");

    statusRef.onChildRemoved.listen((event) {
      setState(() {
        _status = 0;
      });
    });
    statusRef.onValue.listen((event) {
      print("burayaaagirdi");

      if (event.snapshot.exists) {
        print("burayagirdi");
        setState(() {
          _status = event.snapshot.value;
          if (_status == -1) {
            _statusIcon = const Icon(Icons.close, color: Colors.white);
            _statusContainerColor = Colors.red;
            _usageMessage = "Servisi kullanmayacağım.";
          } else if (_status == 0) {
            _statusIcon = const Icon(Icons.watch_later, color: Colors.black);
            _statusContainerColor = const Color(0xfff5c104);
            _usageMessage = "Servise geç kalacağım.";
          } else {
            _statusIcon = const Icon(Icons.check, color: Colors.white);
            _statusContainerColor = Colors.green;
            _usageMessage = "Servisi kullanacağım.";
          }
        });
      }
    });
  }




  void _setStatus(int newStatus) async{
    await FirebaseDatabase.instance.reference().child("routes/${widget.routeID}/passengers/${getUserId()}/status").set(newStatus);

  }

  void togglePanel() => widget.panelController.isPanelClosed
      ? widget.panelController.close()
      : widget.panelController.open();

  void _setShuttleInfo() {
    if (widget.isRoute == false) {
      _speedShuttle = "--";
      _estimatedTime = "--";
      _speedLimit = "--";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _setShuttleInfo();

    return ListView(
      padding: EdgeInsets.zero,
      controller: widget.controller,
      children: <Widget>[
        Stack(
          children: <Widget>[
            // SizedBox(height: size.height * 0.02),
            GestureDetector(
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: size.height * 0.015),
                  width: size.width * 0.1,
                  height: size.height * 0.015,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              onTap: togglePanel,
            ),
            // SizedBox(height: size.height * 0.02),
            Container(
              margin: EdgeInsets.fromLTRB(
                  size.width * 0.75, size.height * 0.125, 0.0, 0.0),
              child: const Text(
                "SERVIS\nKULLANIMI",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  size.width * 0.79, size.height * 0.04, 0.0, 0.0),
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
                          title: const Text("Servis Kullanımı"),
                          content: const Text("Bugün servisi kullanacak mısınız?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _setStatus(-1);
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text("Hayır",
                                    style: TextStyle(color: Colors.white))),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _setStatus(0);
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text("Geç",
                                    style: TextStyle(color: Colors.white))),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _setStatus(1);
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text("Evet",
                                    style: TextStyle(color: Colors.white))),
                          ],
                          elevation: 24.0,
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                        );
                      });
                },
                iconSize: size.width * 0.1,
              ),
            ),
            Padding(
              padding:EdgeInsets.fromLTRB(size.width*0.1,size.height*0.08, 0.0, 0.0),
              child: Text(
                _usageMessage,
                style: TextStyle(fontSize: 25,color: _statusContainerColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
