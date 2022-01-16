import 'package:app/database/functions.dart';
import 'package:app/general/titled_rect_widget_button.dart';
import 'package:app/profile/screen.dart';
import 'package:app/shuttle_edit/screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ShuttleBody extends StatefulWidget {
  final String shuttleId;
  final DataSnapshot? shuttleData;
  final bool editable;

  const ShuttleBody({
    Key? key,
    required this.shuttleId,
    this.shuttleData,
    this.editable = false,
  }) : super(key: key);

  @override
  _ShuttleBodyState createState() => _ShuttleBodyState();
}

class _ShuttleBodyState extends State<ShuttleBody> {
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
    List<String> employees =
        (Map<String, bool>.from(shuttleData.value['employees'])).keys.toList();
    List<Widget> listChildren = [
      Center(
        child: Text(
          shuttleData.value["info"] ?? "Bilgi bulunmamakta",
        ),
      ),
      const Center(
        child: Text("Görevliler:"),
      ),
    ];
    listChildren.addAll(
      List.generate(employees.length, (index) {
        String currId = employees[index];
        return FutureBuilder(
          future: FirebaseDatabase.instance
              .reference()
              .child("users/$currId")
              .once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.exists) {
                String name = snapshot.data!.value["name"];
                String surname = snapshot.data!.value["surname"];
                return TitledRectWidgetButton(
                  borderRadius: BorderRadius.circular(25),
                  title: Text.rich(
                    TextSpan(
                      children: [
                        const Icon(
                          Icons.account_circle,
                          size: 60,
                        ),
                        Text(
                          "$name $surname",
                          style: const TextStyle(fontSize: 30),
                        ),
                      ]
                          .map((e) => WidgetSpan(
                              child: e, alignment: PlaceholderAlignment.middle))
                          .toList(),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.blue,
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(
                        userId: currId,
                        userData: snapshot.data,
                      ),
                    ),
                  ),
                );
              } else {
                return const Text("Bilgi bulunmamakta");
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        );
      }),
    );

    List<Widget> stackChildren = [
      ListView(
        children: listChildren,
      )
    ];

    if (widget.editable) {
      stackChildren.add(
        Container(
          padding: const EdgeInsets.all(15),
          child: FloatingActionButton(
            child: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShuttleEditScreen(
                    shuttleId: widget.shuttleId,
                    shuttleData: widget.shuttleData,
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    return Stack(
      children: stackChildren,
      alignment: Alignment.bottomRight,
    );
  }
}
