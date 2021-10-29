import 'package:flutter/material.dart';

class PageRow extends StatelessWidget {
  final double? height;
  final Widget? leading;
  final List<String> stringChildren;

  const PageRow({
    this.height,
    this.leading,
    this.stringChildren = const [],
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        children: leading == null
            ? stringChildren.map((e) => Expanded(child: Text(e))).toList()
            : [
                leading as Widget,
                ...stringChildren.map((e) => Expanded(child: Text(e))).toList(),
              ],
      ),
    );
  }
}
