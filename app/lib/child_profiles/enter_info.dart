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
        title: Text("Add Child"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Child's name"),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Child's surname"),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Shuttle code"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
