// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:geoflutterfire/geoflutterfire.dart';
// import 'package:location/location.dart';
//
// class FirebaseLocation extends StatefulWidget {
//   const FirebaseLocation({Key? key}) : super(key: key);
//
//   @override
//   _FirebaseLocationState createState() => _FirebaseLocationState();
// }
//
// class _FirebaseLocationState extends State<FirebaseLocation> {
//   @override
//
//   Location _location = new Location();
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   Geoflutterfire geo = Geoflutterfire();
//
//   Future<DocumentReference>_addingPointsLocation() async
//   {
//     var position = await _location.getLocation();
//
//     GeoFirePoint point = geo.point(latitude: position.latitude!, longitude: position.longitude!);
//
//     return _firestore.collection('Locations').add({
//       'Position': point.data,
//       'User Type': 'Student'
//     });
//   }
//
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
