import 'package:flutter/material.dart';

class VisibleTextFieldContainer extends StatefulWidget {
  final ValueChanged<String> changed;
  final TextEditingController? controller;
  final String hintText;
  final Icon preIcon;

  const VisibleTextFieldContainer({
    Key? key,
    required this.changed,
    required this.controller,
    this.hintText = "",
    required this.preIcon,
  }) : super(key: key);

  @override
  _VisibleTextFieldContainerState createState() =>
      _VisibleTextFieldContainerState();
}

class _VisibleTextFieldContainerState extends State<VisibleTextFieldContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.85,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3))
          ]),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: widget.preIcon,
          border: InputBorder.none,
        ),
        onChanged: widget.changed,
      ),
    );
  }
}
