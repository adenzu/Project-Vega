import 'package:app/general/screens.dart';
import 'package:flutter/material.dart';
import '../general/util.dart';

class AddChildButton extends StatelessWidget {
  final String text;
  final String screenName;

  const AddChildButton({
    Key? key,
    required this.text,
    required this.screenName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      // width:300,
      // height: 100,
      //alignment: Alignment.bottomRight,
      child: ElevatedButton(
        onPressed: () => redirectionTo(screenName)(context),
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
