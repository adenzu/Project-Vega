import 'package:app/database/functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PassengerCard extends StatefulWidget {
  final String name;
  final String userId;
  final String routeId;

  const PassengerCard(
      {Key? key,
      required this.name,
      required this.routeId,
      required this.userId})
      : super(key: key);

  @override
  _PassengerCardState createState() => _PassengerCardState();
}

class _PassengerCardState extends State<PassengerCard> {
  bool _isOn = false;
  int status = 0;
  Color iconColor = Colors.green;
  final Color _isOnColor = Colors.green;
  final Color _isOffColor = Colors.red;

  final Icon _isOnIcon = const Icon(
    CupertinoIcons.check_mark_circled_solid,
    color: Colors.white,
  );
  final Icon _isOffIcon = const Icon(
    CupertinoIcons.clear_circled_solid,
    color: Colors.white,
  );

  void _setStatus(int status) {
    if (status == -1) {
      iconColor = Colors.red;
    } else if (status == 0) {
      iconColor = Colors.yellowAccent;
    } else {
      iconColor = Colors.green;
    }
  }

  void _setIsInShuttle(bool newIsInShuttle) async {
    newIsInShuttle
        ? setUserCurrentRoute(widget.userId, widget.routeId)
        : removeUserCurrentRoute(widget.userId);
    await FirebaseDatabase.instance
        .reference()
        .child('routes/${widget.routeId}/passengers/${widget.userId}/isOn')
        .set(newIsInShuttle);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final DatabaseReference routePassengersRef = FirebaseDatabase.instance
        .reference()
        .child("routes/${widget.routeId}/passengers");

    routePassengersRef
        .child('${widget.userId}/isOn')
        .onChildRemoved
        .listen((event) {
      setState(() {
        _isOn = false;
      });
    });
    routePassengersRef.child('${widget.userId}/isOn').onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          _isOn = event.snapshot.value;
        });
      }
    });
    //.....................................................................
    routePassengersRef
        .child('${widget.userId}/status')
        .onChildRemoved
        .listen((event) {
      setState(() {
        status = 0;
      });
    });
    routePassengersRef.child('${widget.userId}/status').onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          status = event.snapshot.value;
        });
      }
    });
    //........................................................................
  }

  @override
  Widget build(BuildContext context) {
    _setStatus(status);
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      height: size.height * 0.12,
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(bottom: size.height * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.black87),
        color: const Color(0xc4636fc9),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: CircleAvatar(
                child: Icon(Icons.person, size: size.width * 0.1),
                backgroundColor: iconColor,
                radius: 30),
          ),
          Expanded(
            flex: 2,
            child: Text(
              widget.name.toUpperCase(),
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  color: _isOn ? _isOnColor : _isOffColor,
                  borderRadius: BorderRadius.circular(30.0)),
              child: IconButton(
                icon: _isOn ? _isOnIcon : _isOffIcon,
                onPressed: () async {
                  _setIsInShuttle(!_isOn);
                },
                iconSize: size.width * 0.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
