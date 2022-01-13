import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DriverInfoContainer extends StatefulWidget {
  final int _shuttleID;

  const DriverInfoContainer(int shuttleID) : _shuttleID = shuttleID;

  @override
  State<DriverInfoContainer> createState() => _DriverInfoContainerState();
}

class _DriverInfoContainerState extends State<DriverInfoContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(

      alignment: Alignment.topLeft,
      padding: EdgeInsets.fromLTRB(size.width * 0.005,
          size.height * 0.01, size.width * 0.01, size.height * 0.005),
      child: Material(
        color: Colors.orange,
        child: InkWell(
          onTap: () {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Driver Info"),
                    content: const Text("Driver Info will be printed here."),
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
            width: size.width * 0.32,
            child: Container(
              padding: EdgeInsets.only(top:size.height*0.03),
              width: size.width * 0.3,
              height: size.height * 0.2,
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.height*0.06),
                  Icon(
                    CupertinoIcons.person_crop_circle_fill_badge_checkmark,
                    color: Colors.white,
                    size: size.width * 0.25,
                  ),
                  const Text("Driver",
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
