import 'package:flutter/material.dart';
import '../general/util.dart';

class RedirectionButton extends StatelessWidget {
  final String text;
  final String screenName;

  const RedirectionButton({
    Key? key,
    String name = "",
    String shuttleNumber = "",
    required this.text,
    required this.screenName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: ElevatedButton(
        onPressed: () => redirectionTo(screenName)(context),
        child: Row(children: [
          const SizedBox(
            height: 90,
            width: 90,
            child: CircleAvatar(
              backgroundColor: Colors.white70, // backgroundimage olacak
              child: Icon(
                Icons.person,
                size: 50,
              ),
            ),
          ),
          const SizedBox(
            height: 100,
            width: 10,
          ),
          Column(children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              text,
              style: TextStyle(height: 1.2, fontSize: 18),
            ),
          ]),
        ]),
      ),
    );
  }
}
