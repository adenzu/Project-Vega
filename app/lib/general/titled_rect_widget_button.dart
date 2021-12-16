import 'package:flutter/material.dart';

class TitledRectWidgetButton extends StatelessWidget {
  final Widget title;
  final Widget child;
  final void Function() onTap;
  final AlignmentGeometry alignment;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const TitledRectWidgetButton({
    Key? key,
    required this.title,
    required this.child,
    required this.onTap,
    this.alignment = AlignmentDirectional.bottomStart,
    this.borderRadius = BorderRadius.zero,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: alignment,
      children: [
        ClipRRect(
          borderRadius: borderRadius,
          child: child,
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: borderRadius,
              onTap: onTap,
            ),
          ),
        ),
        Container(
          padding: padding,
          child: title,
        ),
      ],
    );
  }
}