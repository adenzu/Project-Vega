import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SLicenseInfoContainer extends StatefulWidget {
  final int _shuttleID;

  const SLicenseInfoContainer(int shuttleID) : _shuttleID = shuttleID;

  @override
  State<SLicenseInfoContainer> createState() => _SLicenseInfoContainerState();
}

class _SLicenseInfoContainerState extends State<SLicenseInfoContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(

      alignment: Alignment.topLeft,
      padding: EdgeInsets.fromLTRB(size.width * 0.005,
          size.height * 0.005, size.width * 0.01, size.height * 0.01),
      child: Material(
        color: Colors.lightGreen,
        child: InkWell(
          onTap: () {
            showDialog(
                barrierDismissible: true,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("License Info"),
                    content: const Text("License Info will be printed here."),
                    elevation: 24.0,
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  );
                });
            //setState(() {});
          },
          child: Container(
            height: size.height * 0.335,
            width: size.width * 0.59,
            child: Container(
              padding: EdgeInsets.only(top:size.height*0.03),
              width: size.width * 0.3,
              height: size.height * 0.2,
              child: Column(
                children: <Widget>[
                  SizedBox(height: size.height*0.06),
                  Icon(
                    CupertinoIcons.doc_text_search,
                    color: Colors.white,
                    size: size.width * 0.3,
                  ),
                  const Text("License",
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
