import 'package:app/database/functions.dart';
import 'package:app/general/screens.dart';
import 'package:flutter/material.dart';
import '../general/util.dart';

class AddChildButton extends StatelessWidget {
  final String text;

  const AddChildButton({
    Key? key,
    this.text = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController lastNameController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController shuttleIDController = TextEditingController();
    return Align(
      // width:300,
      // height: 100,
      alignment: Alignment.bottomRight,
      child: ElevatedButton(
        child: Icon(
          Icons.add,
          size: 18.0,
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(15),
          primary: Colors.orange, // <-- Button color
          onPrimary: Colors.white, // <-- Splash color
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                title: Text("Add Child"),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            labelText: "Child's Name",
                            icon: Icon(Icons.person),
                          ),
                        ),
                        TextFormField(
                          controller: lastNameController,
                          decoration: InputDecoration(
                            labelText: "Child's Surname",
                            icon: Icon(Icons.person),
                          ),
                        ),
                        TextFormField(
                          controller: shuttleIDController,
                          decoration: InputDecoration(
                            labelText: 'Shuttle Code',
                            icon: Icon(Icons.car_rental),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                    child: Text("Submit"),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      String childid = await generateChildId();
                      createUser(childid, {
                        'name': firstNameController.text,
                        'surname': lastNameController.text,
                        'shuttles': {shuttleIDController.text: true},
                      });
                      addChild(childid);
                      subscribeToShuttle(childid, shuttleIDController.text);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
