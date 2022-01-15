import 'package:app/database/functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShuttleEditBody extends StatefulWidget {
  final String shuttleId;
  final DataSnapshot? shuttleData;

  const ShuttleEditBody({
    Key? key,
    required this.shuttleId,
    this.shuttleData,
  }) : super(key: key);

  @override
  _ShuttleEditBodyState createState() => _ShuttleEditBodyState();
}

class _ShuttleEditBodyState extends State<ShuttleEditBody> {
  late DataSnapshot shuttleData;
  TextEditingController shuttleInfoController = TextEditingController();

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
    return Stack(
      children: [
        TextFormField(
          controller: shuttleInfoController,
          maxLines: 100,
          keyboardType: TextInputType.multiline,
        ),
        FloatingActionButton(
          child: const Icon(Icons.done),
          onPressed: () {
            setShuttleInfo(widget.shuttleId, shuttleInfoController.text);
          },
        )
      ],
    );
  }
}
