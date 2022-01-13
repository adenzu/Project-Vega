import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PassengersInfoContainer extends StatefulWidget {
  final int _shuttleID;

  const PassengersInfoContainer(int shuttleID) : _shuttleID = shuttleID;

  @override
  State<PassengersInfoContainer> createState() => _PassengersInfoContainerState();
}

class _PassengersInfoContainerState extends State<PassengersInfoContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.fromLTRB(size.width * 0.01,
          size.height * 0.005, size.width * 0.005, size.height * 0.01),
      child: Material(
        color: Colors.amber,
        child: InkWell(
          onTap: () {
            // showDialog(
            //     barrierDismissible: true,
            //     context: context,
            //     builder: (BuildContext context) {
            //       return AlertDialog(
            //         title: const Text("Shuttle Usage"),
            //         content: const Text("Will you use shuttle today?"),
            //         actions: [
            //           const Text("No",
            //               style: TextStyle(
            //                 color: Colors.white,
            //               )),
            //           const Text("Late", style: TextStyle(color: Colors.white)),
            //           const Text("Yes", style: TextStyle(color: Colors.white)),
            //         ],
            //         elevation: 24.0,
            //         backgroundColor: Colors.blueAccent,
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(20.0)),
            //       );
            //     });
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Passengers Info"),
                    content: const Text("Pass Info will be printed here."),
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
            width: size.width * 0.38,
            child: Container(
              padding: EdgeInsets.only(top:size.height*0.03),
              width: size.width * 0.3,
              height: size.height * 0.2,
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.height*0.06),
                  Icon(
                    CupertinoIcons.person_3_fill,
                    color: Colors.white,
                    size: size.width * 0.3,
                  ),
                  const Text("Passengers",
                    style: TextStyle(fontSize: 20,color: Colors.white,letterSpacing: 1.5),
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
