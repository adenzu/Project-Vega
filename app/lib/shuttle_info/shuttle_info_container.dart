import 'package:flutter/material.dart';

class ShuttleInfoContainer extends StatefulWidget {
  final int _shuttleID;

  const ShuttleInfoContainer(int shuttleID) : _shuttleID = shuttleID;

  @override
  State<ShuttleInfoContainer> createState() => _ShuttleInfoContainerState();
}

class _ShuttleInfoContainerState extends State<ShuttleInfoContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.fromLTRB(size.width * 0.01, size.height * 0.01,
          size.width * 0.005, size.height * 0.005),
      child: Material(
        color: Colors.blue,
        child: InkWell(
          onTap: () {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Shuttle Info"),
                    content: const Text("Shuttle Info will be printed here."),
                    elevation: 24.0,
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  );
                });
            //setState(() {});
          },
          child: SizedBox(
            height: size.height * 0.335,
            width: size.width * 0.65,
            child: Container(
              padding: EdgeInsets.only(top:size.height*0.03),
              width: size.width * 0.3,
              height: size.height * 0.2,
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.height*0.06),
                  Icon(
                    Icons.directions_bus,
                    color: Colors.white,
                    size: size.width * 0.3,
                  ),
                  const Text("Shuttle",
                      style: TextStyle(fontSize: 24,color: Colors.white,letterSpacing: 2),
                      textAlign: TextAlign.center,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
