import 'package:flutter/material.dart';
import '../profile/screen.dart';
import '../my_shuttles/screen.dart';
import '../child_profiles/screen.dart';

class Redirection extends StatelessWidget {
  const Redirection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Row(
          children: <Widget>[
            
         Container(
    margin: const EdgeInsets.all(10.0),
    color: Colors.amber[600],
    width: 100.0,
    height: 100.0,
        child: ElevatedButton(
            style: style,
            onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyShuttlesScreen()));},
            child: const Text('Redirection to My Shuttles'),
          ),
        ),
            
        Container(
    margin: const EdgeInsets.all(10.0),
    color: Colors.amber[600],
    width: 100.0,
    height: 100.0,
        child: ElevatedButton(
            style: style,
            onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChildProfilesScreen()));},
            child: const Text('Redirection to Child Profiles'),
          ),
        ),
        Container(
    margin: const EdgeInsets.all(10.0),
    color: Colors.amber[600],
    width: 100.0,
    height: 100.0,
        child: ElevatedButton(
            style: style,
            onPressed: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfileScreen()));},
            child: const Text('Redirection to Profile'),
          ),
        ),
          ],
    );

  }

}