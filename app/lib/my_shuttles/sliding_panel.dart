import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SlidingPanel extends StatefulWidget {
  final ScrollController controller;
  final PanelController panelController;

  const SlidingPanel(
      {Key? key, required this.controller, required this.panelController})
      : super(key: key);

  @override
  State<SlidingPanel> createState() => _SlidingPanelState();
}

class _SlidingPanelState extends State<SlidingPanel> {
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

  void togglePanel() => widget.panelController.isPanelClosed
      ? widget.panelController.close()
      : widget.panelController.open();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  width: size.width*0.1,
                  height: size.height*0.015,
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
                "USAGE\nSTATUS",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  size.width * 0.76, size.height * 0.04, 0.0, 0.0),
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
                          content: const Text("Will you use shuttle today?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _setStatus(-1);
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text("No",
                                    style: TextStyle(color: Colors.white))),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _setStatus(0);
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text("Late",
                                    style: TextStyle(color: Colors.white))),
                            TextButton(
                                onPressed: () {
                                  setState(() {
                                    _setStatus(1);
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text("Yes",
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
            Container(
              margin: EdgeInsets.fromLTRB(
                  size.width * 0.38, size.height*0.06, size.width * 0.1, 0.0),
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
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // border: Border.all(width: 1.5),
                    ),
                    child: Row(
                      children: [
                        const Text("45",
                            style:
                                TextStyle(fontSize: 25, color: Colors.black)),
                        const SizedBox(width: 7.0),
                        Column(
                          children: const [
                            Text("100",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.orange)),
                            Text("KM/H",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  size.width * 0.08, size.height * 0.08, 0.0, 0.0),
              child: Text("45 min",
                  style: TextStyle(
                      fontSize: size.width * 0.07,
                      color: const Color(0xf5080887))),
            ),
          ],
        ),
      ],
    );
  }
}
