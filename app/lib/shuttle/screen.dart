import 'package:app/database/functions.dart';
import 'package:app/shuttle/body.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShuttleScreen extends StatefulWidget {
  final String shuttleId;

  const ShuttleScreen({Key? key, required this.shuttleId}) : super(key: key);

  @override
  _ShuttleScreenState createState() => _ShuttleScreenState();
}

class _ShuttleScreenState extends State<ShuttleScreen> {
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
                        text: "Kod: ${widget.shuttleId}",
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
              body: ShuttleBody(
                shuttleId: widget.shuttleId,
                shuttleData: snapshot.data,
                editable: true,
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
