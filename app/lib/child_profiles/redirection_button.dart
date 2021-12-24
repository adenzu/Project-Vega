import 'package:flutter/material.dart';
import '../util.dart';

class RedirectionButton extends StatelessWidget {
  final String text;
  //final Widget Function(BuildContext) builder;

  const RedirectionButton({
    Key? key,
    String name = "",
    String shuttleNumber = "",
    required this.text,
    //required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: ElevatedButton(
        onPressed: () {
          //burdan
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
                    RaisedButton(
                        child: Text(""),
                        onPressed: () {
                          // your code
                        })
                  ],
                );
              });
          //buraya
        },
        child: Row(children: [
          const SizedBox(
            height: 90,
            width: 90,
            child: CircleAvatar(
              backgroundColor: Colors.white70, // backgroundimage olacak
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
          ),
          const SizedBox(
            height: 100,
            width: 10,
          ),
          Column(children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              text,
              style: TextStyle(height: 1.2, fontSize: 18),
            ),
          ]),
        ]),
      ),
    );
  }
}
