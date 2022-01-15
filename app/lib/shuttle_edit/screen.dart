import 'package:app/database/functions.dart';
import 'package:app/shuttle_edit/body.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShuttleEditScreen extends StatefulWidget {
  final String shuttleId;
  final DataSnapshot? shuttleData;

  const ShuttleEditScreen({
    Key? key,
    required this.shuttleId,
    this.shuttleData,
  }) : super(key: key);

  @override
  _ShuttleEditScreenState createState() => _ShuttleEditScreenState();
}

class _ShuttleEditScreenState extends State<ShuttleEditScreen> {
  late DataSnapshot shuttleData;

  void settleShuttleData() async {
    shuttleData = widget.shuttleData ??
        (await FirebaseDatabase.instance
                .reference()
                .child("shuttles/${widget.shuttleId}")
                .once())
            .value;
  }

  @override
  void initState() {
    super.initState();
    settleShuttleData();
  }

  @override
  Widget build(BuildContext context) {
    String seatCount = shuttleData.value["seatCount"];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(shuttleData.value["plate"]),
        leading:
            Text("${concurrentPassengerCount(widget.shuttleId)}/$seatCount"),
        foregroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ShuttleEditBody(
        shuttleId: widget.shuttleId,
        shuttleData: shuttleData,
      ),
    );
  }
}
