import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PassengerCard extends StatefulWidget {
  final String name;
  final int status;
  final bool isOn;
  final String userId;
  final String routeId;



   PassengerCard({Key? key,required this.name,required this.isOn, required this.status, required this.routeId, required this.userId}) : super(key: key);



  @override
  _PassengerCardState createState() => _PassengerCardState();
}

class _PassengerCardState extends State<PassengerCard> {
  bool _isInShuttle = false;
  Color iconColor = Colors.green;
  Color _isInShuttleColor = Colors.green;
  Icon _isInShuttleIcon = const Icon(CupertinoIcons.check_mark_circled_solid,color: Colors.white,);

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
    _isInShuttle = newIsInShuttle;
    await FirebaseDatabase.instance.reference().child('routes/${widget.routeId}/passengers/${widget.userId}/isOn').set(newIsInShuttle);
    // if (!_isInShuttle ) {
    //   _isInShuttleIcon = const Icon(CupertinoIcons.clear_circled_solid, color: Colors.white);
    //   _isInShuttleColor = Colors.red;
    // } else {
    //   _isInShuttleIcon = const Icon(CupertinoIcons.check_mark_circled_solid,color: Colors.white,);
    //   _isInShuttleColor = Colors.green;
    // }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setStatus(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return   Container(
      width: size.width*0.95,
      height: size.height* 0.12,
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(
          bottom: size.height * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.black87),
        color: const Color(0xc4636fc9),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: CircleAvatar(child: Icon(Icons.person,size: size.width* 0.1),backgroundColor: iconColor ,radius: 30),
          ),
          Expanded(
            flex: 2,
            child: Text(widget.name.toUpperCase(),style: const TextStyle(fontSize: 18),textAlign: TextAlign.center,),
          ),
          Expanded(
            flex: 2,
            child: Container(

              decoration: BoxDecoration(
                  color: _isInShuttleColor,
                  borderRadius: BorderRadius.circular(30.0)),
              child: IconButton(
                icon: widget.isOn ? Icon(Icons.check) : Icon(Icons.close),
                onPressed: () async {
                  _setIsInShuttle(!_isInShuttle);
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
