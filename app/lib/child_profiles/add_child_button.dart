import 'package:app/database/functions.dart';
import 'package:app/general/screens.dart';
import 'package:flutter/material.dart';
import '../general/util.dart';

class AddChildButton extends StatelessWidget {
  final String text;
//  final String screenName;

  const AddChildButton({
    Key? key,
    required this.text,
    // required this.screenName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      // width:300,
      // height: 100,
      //alignment: Alignment.bottomRight,
      child: ElevatedButton(
//<<<<<<< HEAD
        child: Icon(
          Icons.add,
          size: 18.0,
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(15),
          primary: Colors.blue, // <-- Button color
          onPrimary: Colors.white, // <-- Splash color
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text("Add Child"),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Child's Name",
                              icon: Icon(Icons.person),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Child's Surname",
                              icon: Icon(Icons.person),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Shuttle Code',
                              icon: Icon(Icons.car_rental),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(child: Text("Submit"), onPressed: () {})
                  ],
                );
              });
        },
      ),
    );
  }
}
