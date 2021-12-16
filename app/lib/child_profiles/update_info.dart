import 'package:flutter/material.dart';

class UpdateInfo extends StatefulWidget {
  UpdateInfo({Key? key}) : super(key: key);

  @override
  _UpdateInfoState createState() => _UpdateInfoState();
}

class _UpdateInfoState extends State<UpdateInfo> {
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
