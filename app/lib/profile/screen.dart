import 'package:flutter/material.dart';

import 'body.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;
  final bool editable;
  final bool canSeeParents;

  const ProfileScreen({
    Key? key,
    required this.userId,
    this.editable = false,
    this.canSeeParents = false,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileBody(
        userId: widget.userId,
        editable: widget.editable,
        canSeeParents: widget.canSeeParents,
      ),
    );
  }
}