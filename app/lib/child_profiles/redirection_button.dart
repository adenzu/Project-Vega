import 'package:flutter/material.dart';
import '../general/util.dart';

class RedirectionButton extends StatelessWidget {
  final String text;

  const RedirectionButton({
    Key? key,
    String name = "",
    String shuttleNumber = "",
    required this.text,
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
                  title: Text("Child Info"),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          Text("Oğuz Acar"),
                          Text(
                            //decoration: InputDecoration(
                            'Shuttle Code',
                            textAlign: TextAlign.left,
                            // icon: Icon(Icons.car_rental),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                        child: Text("Edit"),
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
