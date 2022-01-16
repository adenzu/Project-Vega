import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class MyShuttleMapBody extends StatefulWidget {
  const MyShuttleMapBody({Key? key}) : super(key: key);

  @override
  _MyShuttleMapBodyState createState() => _MyShuttleMapBodyState();
}

class _MyShuttleMapBodyState extends State<MyShuttleMapBody> {
  GoogleMapController? _controller;
  Location _location = new Location();
  StreamSubscription? _locationSubscriber;
  Marker? _shuttleMarker;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final database = FirebaseDatabase.instance.reference(); // path to location
  late double lat;
  late double long;
  late double shuttlelat;
  late double shuttlelong;

  // Geoflutterfire geo = Geoflutterfire();

  static const _initialCamera = CameraPosition(
    target: LatLng(40.806298, 29.355541),
    zoom: 14.5,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _location.onLocationChanged.listen((l) {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(l.latitude!, l.longitude!), zoom: 14.5)),
      );
    });
  }

  // final Set<Marker> _shuttleMarker = Set();

  Future<Uint8List> getMarker() async {
    ByteData byteData =
    await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
    return byteData.buffer.asUint8List();
  }


  void refreshmarker(LocationData newData, Uint8List imagedat) {
    LatLng latitudelongitude = LatLng(shuttlelat, shuttlelong);
    lat = newData.latitude!;
    long = newData.longitude!;

    setState(() {
      _shuttleMarker = Marker(
        markerId: MarkerId("Shuttle"),
        position: latitudelongitude,
        rotation: newData.heading!,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        icon: BitmapDescriptor.fromBytes(imagedat),
      );
    });
  }

  // Future<DocumentReference> _addGeoPoint() async {
  //   var pos = await _location.getLocation();
  //   GeoFirePoint point = geo.point(latitude: pos.latitude!, longitude: pos.longitude!);
  //   print("deneme123");
  //   return firestore.collection('locations').add({
  //     'position': point.data,
  //     'name': 'Yay I can be queried!'
  //   });
  // }
void _getshuttleLoc() async{

    database.child('shuttles/shuttleId/location/latitude').onValue.listen((event) {
    shuttlelat = event.snapshot.value;
    print(shuttlelat);
  });
    database.child('shuttles/shuttleId/location/longitude').onValue.listen((event) {
      shuttlelong = event.snapshot.value;
      print(shuttlelong);
    });

}
  void _getcurrentLoc() async {
    try {
      Uint8List imagedata = await getMarker();

      var location = await _location.getLocation();
      refreshmarker(location, imagedata);

      if (_locationSubscriber != null) {
        _locationSubscriber!.cancel();
      }

      _locationSubscriber = _location.onLocationChanged.listen((newData) {
        if (_controller != null) {
          _controller!
              .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(newData.latitude!, newData.longitude!),
            zoom: 14.5,
            bearing: 192.8334901395799,
            tilt: 0,
          )));
          refreshmarker(newData, imagedata);
        }
      });
    } on PlatformException catch (error) {
      if (error.code == 'PERMISSION DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscriber != null) {
      _locationSubscriber!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    final shuttlesRef = database.child('shuttles/shuttleId/location');


    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: GoogleMap(
              markers: Set.of(
                  (_shuttleMarker != null) ? [_shuttleMarker!] : []),
              mapType: MapType.normal,
              initialCameraPosition: _initialCamera,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              // markers: Set.of((marker != null)),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                size.width * 0.83, size.height * 0.4, 0.0, 0.0),
            child: Container(
              child:
              FloatingActionButton(
                child: const Icon(CupertinoIcons.bus,size: 35,color: Colors.white,),
                onPressed: () {
                  _getshuttleLoc();
                  _getcurrentLoc();
                  // try{
                  //   shuttlesRef.set({'latitude': lat,'longitude': long });
                  //   print('WRITE SUCCESFULLY');
                  // }catch(e){
                  //   print('You got an database error');
                  // }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}