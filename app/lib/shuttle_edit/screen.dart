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
    return FutureBuilder(
      future: FirebaseDatabase.instance
          .reference()
          .child("shuttles/${widget.shuttleId}")
          .once(),
      builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.exists) {
            String plate = snapshot.data!.value["plate"];
            String seatCount = snapshot.data!.value["seatCount"].toString();

            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text.rich(
                  TextSpan(
                    text: "$plate\n",
                    children: [
                      TextSpan(
                        text: widget.shuttleId,
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  FutureBuilder(
                    future: concurrentPassengerCount(widget.shuttleId),
                    builder: (context, AsyncSnapshot<int> snapshot) => Center(
                      child: Text(
                        "${snapshot.data}/$seatCount",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
                foregroundColor: Colors.blue,
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              body: ShuttleEditBody(
                shuttleId: widget.shuttleId,
                shuttleData: snapshot.data,
              ),
            );
          } else {
            return const Text("Bilgi bulunmuyor");
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
