import 'package:flutter/material.dart';
import '../util.dart';

class AddChildButton extends StatelessWidget {
  final String text;
  final Widget Function(BuildContext) builder;

  const AddChildButton({
    Key? key,
    required this.text,
    required this.builder,
  }) : super(key: key);

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
