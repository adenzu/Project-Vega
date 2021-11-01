import 'package:flutter/material.dart';

import 'list_block.dart';

import '../profile/screen.dart';
import '../my_shuttles/screen.dart';
import '../child_profiles/screen.dart';

class MainBody extends StatelessWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return Column(
      children:  <Widget>[
        ListBlock(),
        Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
              searchBar(),
              ],
            ),
            ),
        ),
        ),
        
        Row(
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
    ),
      ],
    );
  }
  Widget searchBar(){
    return TextFormField(
          decoration: InputDecoration(labelText: "Search Bar", hintText: "asdfg"),
        );
  }
}
