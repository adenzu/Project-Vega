import 'package:flutter/material.dart';

class SlideMenuTile extends StatelessWidget {
  final String title;
  final IconData iconData;
  final void Function()? onTap;

  const SlideMenuTile({
    Key? key,
    required this.title,
    required this.iconData,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Colors.grey[700],
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          // color: Colors.grey[600],
        ),
      ),
      horizontalTitleGap: 0,
      onTap: onTap,
    );
  }
}