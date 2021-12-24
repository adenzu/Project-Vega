import 'package:flutter/material.dart';
import '../util.dart';

class AddChildButton extends StatelessWidget {
  final String text;
  //final Widget Function(BuildContext) builder;

  const AddChildButton({
    Key? key,
    required this.text,
    //required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      // width:300,
      // height: 100,
      //alignment: Alignment.bottomRight,
      child: ElevatedButton(
        child: Icon(
          Icons.add,
          size: 18.0,
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(15),
          primary: Colors.blue, // <-- Button color
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
                            decoration: InputDecoration(
                              labelText: "Child's Name",
                              icon: Icon(Icons.person),
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: "Child's Surname",
                              icon: Icon(Icons.person),
                            ),
                          ),
                          TextFormField(
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
                    RaisedButton(
                        child: Text("Submit"),
                        onPressed: () {
                          // your code
                        })
                  ],
                );
              });
        },
      ),
    );
  }
}



/*
RaisedButton(
          child: Text("Open Popup"),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    scrollable: true,
                    title: Text('Login'),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Name',
                                icon: Icon(Icons.account_box),
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                icon: Icon(Icons.email),
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Message',
                                icon: Icon(Icons.message ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                     actions: [
                      RaisedButton(
                          child: Text("Submit"),
                          onPressed: () {
                            // your code
                          })
                    ],
                  );
                });
          },
        ),
 
 
 
 
 
 
  @override
  Widget build(BuildContext context) {
    return Align(
      // width:300,
      // height: 100,
      //alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () => redirectionTo(builder)(context),
        child: Icon(
          Icons.add,
          size: 18.0,
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(15),
          primary: Colors.blue, // <-- Button color
          onPrimary: Colors.white, // <-- Splash color
        ),
      ),
    );
  }
}

 
 
 */