import 'package:flutter/material.dart';
import 'driver_info_container.dart';
import 'passengers_info_container.dart';
import 'shuttle_info_container.dart';
import 'slicense_info_container.dart';

class ShuttleInfoScreenBody extends StatefulWidget {
  final int shuttleID;

  const ShuttleInfoScreenBody({Key? key, required this.shuttleID})
      : super(key: key);

  @override
  State<ShuttleInfoScreenBody> createState() => _ShuttleInfoScreenBodyState();
}

class _ShuttleInfoScreenBodyState extends State<ShuttleInfoScreenBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          width: size.width,
          height: size.height * 0.3,

          // decoration: const BoxDecoration(
          //   gradient: const LinearGradient(
          //     colors: [
          //       Color(0xa84c56a8),
          //       Color(0xf56776f5),
          //       Color(0xf57c2da8),
          //       Color(0xf5b749f5)
          //     ],
          //     begin: Alignment.centerLeft,
          //     end: Alignment.centerRight,
          //   ),
          // ),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                    size.width * 0.08, size.height * 0.10, 0.0, 0.0),
                child: Text(
                  "VEGA",
                  style: TextStyle(
                      fontSize: 120,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent.withOpacity(0.14)),
                  textAlign: TextAlign.center,
                ),
                // child:Text(
                //   "VEGA",
                //   style: TextStyle(
                //     fontSize: 120,
                //     letterSpacing: 3,
                //     fontWeight: FontWeight.bold,
                //     foreground: Paint()
                //       ..style = PaintingStyle.stroke
                //       ..strokeWidth = 6
                //       ..color = Colors.blue[100]!,
                //   ),
                // ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    size.width * 0.12, size.height * 0.16, 0.0, 0.0),
                child: Text(
                  "INFORMATION",
                  style: TextStyle(
                    fontSize: 40,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                    color: Color(0xf503173d),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            ShuttleInfoContainer(widget.shuttleID),
            DriverInfoContainer(widget.shuttleID),
          ],
        ),
        Row(
          children: [
            PassengersInfoContainer(widget.shuttleID),
            SLicenseInfoContainer(widget.shuttleID),
          ],
        ),
        // Padding(
        //   padding: EdgeInsets.fromLTRB(size.width *0.05,size.height * 0.35,size.width *0.05,size.height * 0.05),
        //   child: GridView.builder(
        //     itemCount: 4,
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 2,
        //         mainAxisSpacing: size.height * 0.1,
        //         crossAxisSpacing: size.width * 0.15),
        //     itemBuilder: (context, index) =>
        //         Container(
        //
        //           child: ShuttleInfoContainer(
        //             shuttleID: infoList[index].shuttleID,
        //             bodyName: infoList[index].bodyName,
        //             titleName: infoList[index].titleName,
        //             containerColor: infoList[index].containerColor,
        //             icon: infoList[index].icon
        //           ),
        //         ),
        //   ),
        // ),
        // Row(
        //   children: <Widget>[
        //     ShuttleInfoContainer(
        //       icon: Icon(Icons.perm_identity),
        //       shuttleID: 0,
        //       titleName: "Identity",
        //       bodyName: "Test User",
        //       containerColor: Colors.orangeAccent,
        //     ),
        //     ShuttleInfoContainer(
        //         icon: Icon(Icons.perm_identity),
        //         shuttleID: 0,
        //         titleName: "Identity",
        //         bodyName: "Test User",
        //         containerColor: Colors.orangeAccent),
        //   ],
        // ),
        // Row(
        //   children: <Widget>[
        //     ShuttleInfoContainer(
        //         icon: Icon(Icons.perm_identity),
        //         shuttleID: 0,
        //         titleName: "Identity",
        //         bodyName: "Test User",
        //         containerColor: Colors.blue),
        //     ShuttleInfoContainer(
        //         icon: Icon(Icons.perm_identity),
        //         shuttleID: 0,
        //         titleName: "Identity",
        //         bodyName: "Test User",
        //         containerColor: Colors.blue),
        //   ],
        // ),
      ],
    );
  }
}
