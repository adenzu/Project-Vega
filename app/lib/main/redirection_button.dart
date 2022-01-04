import 'package:flutter/material.dart';

import '../general/titled_rect_widget_button.dart';
import '../general/util.dart';

class MainPageRedirectionButton extends StatelessWidget {
  final IconData icon;
  final Color iconForegroundColor, iconBackgroundColor;
  final String text;
  final Color textColor;
  final String imageName;
  final String screenName;
  final double? width, height;
  final EdgeInsets padding;
  final double borderRadiusValue;
  final double iconSize, iconBackgroundSize;
  final double gap;
  final double fontSize;
  final Widget navigateTo;

  const MainPageRedirectionButton({
    Key? key,
    required this.icon,
    this.iconForegroundColor = Colors.black38,
    this.iconBackgroundColor = Colors.transparent,
    required this.text,
    this.textColor = Colors.white,
    required this.imageName,
    required this.screenName,
    this.width = double.infinity,
    this.height,
    this.padding = const EdgeInsets.all(10),
    this.borderRadiusValue = 32,
    this.iconSize = 32,
    this.iconBackgroundSize = 5,
    this.gap = 5,
    this.fontSize = 24,
    required this.navigateTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitledRectWidgetButton(
      title: Text.rich(
        TextSpan(
          children: [
            Container(
              padding: EdgeInsets.all(iconBackgroundSize),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBackgroundColor,
              ),
              child: Icon(
                icon,
                color: iconForegroundColor,
                size: iconSize,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: gap),
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                ),
              ),
            )
          ]
              .map((e) =>
                  WidgetSpan(alignment: PlaceholderAlignment.middle, child: e))
              .toList(),
        ),
      ),
      child: Container(
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
            begin: Alignment.lerp(Alignment.center, Alignment.bottomCenter, 0)
                as AlignmentGeometry,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Image.asset(
          imageName,
          fit: BoxFit.fitWidth,
          width: width,
          height: height,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigateTo),
        );
      },
      borderRadius: BorderRadius.circular(borderRadiusValue),
      padding: padding,
    );
  }
}
