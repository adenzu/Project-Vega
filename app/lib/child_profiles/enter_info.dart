import 'package:app/database/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EnterInfo extends StatefulWidget {
  EnterInfo({Key? key}) : super(key: key);

  @override
  _EnterInfoState createState() => _EnterInfoState();
}

class _EnterInfoState extends State<EnterInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Child"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const TextField(
                decoration: InputDecoration(labelText: "Child's name"),
              ),
              const TextField(
                decoration: InputDecoration(labelText: "Child's surname"),
              ),
              const TextField(
                decoration: InputDecoration(labelText: "Shuttle code"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
