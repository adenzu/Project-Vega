import 'package:app/database/functions.dart';
import 'package:app/employee_shuttles/passenger_card.dart';
import 'package:app/general/titled_rect_widget_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RouteBody extends StatefulWidget {
  final String routeID;

  const RouteBody({Key? key, required this.routeID}) : super(key: key);

  @override
  _RouteBodyState createState() => _RouteBodyState();
}

class _RouteBodyState extends State<RouteBody> {

  late DatabaseReference routePassengersRef = FirebaseDatabase.instance
      .reference()
      .child("routes/${widget.routeID}/passengers");
  _fetchStatus(String userID) async {
    FirebaseDatabase.instance.reference().child("routes/${widget.routeID}/passengers/$userID/status").onValue.listen((event) => event.snapshot.value);
  }



  List<String> passengersIds = [];
  List<dynamic> statusPassengers = [];
  List<dynamic> abc = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
print(widget.routeID);
    routePassengersRef.onChildRemoved.listen((event) {
      setState(() {
        passengersIds.clear();
      });
    });
    routePassengersRef.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
        print('yeterartik');
        passengersIds =
             Map<String, dynamic>.from(event.snapshot.value).keys.toList();
          });
      }
    });
    print(passengersIds);

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return passengersIds.isEmpty
        ? const Center(
      child: Text(
        "Rotaniz ....",
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      ),
    )
        : ListView.builder(
      itemCount: passengersIds.length,
      itemBuilder: (context, index) {
        String currId = passengersIds[index];
        bool isOn = false;
        int status = 0;

        routePassengersRef.child('$currId/isOn').onChildRemoved.listen((event) {
          setState(() {
            isOn = false;
          });
        });
        routePassengersRef.child('$currId/isOn').onValue.listen((event) {
          if(event.snapshot.exists){
            setState(() {
              isOn = event.snapshot.value;
            });
          }
        });

        routePassengersRef.child('$currId/status').onChildRemoved.listen((event) {
          setState(() {
            status = 0;
          });
        });
        routePassengersRef.child('$currId/status').onValue.listen((event) {
          if(event.snapshot.exists){
            setState(() {
              status = event.snapshot.value;
            });
          }
        });
                return FutureBuilder(future: getUserData(userId: currId), builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.exists){
                      String name = snapshot.data!.value['name'];
                      String surname = snapshot.data!.value['surname'];
                      return PassengerCard(name: '$name $surname', isOn: isOn, status: status, routeId: widget.routeID, userId: currId);
                    }
                    else{
                      return Text('Bilgi bulunmuyor.');
                    }
                  
            } else {
              return Container(
                padding: const EdgeInsets.all(40),
                width: double.infinity,
                height: 150,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        );
      },
    );
  }
}
