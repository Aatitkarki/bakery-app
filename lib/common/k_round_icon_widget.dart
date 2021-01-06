import 'package:bakery/common/ui/ui_helper.dart';
import 'package:bakery/theme/colors.dart';
import 'package:flutter/material.dart';

class RoundIconWidget extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Color backgroundColor;
  final Function onPressed;
  final EdgeInsets padding;
  final List<BoxShadow> boxShadow;

  const RoundIconWidget({
    @required this.iconData,
    this.iconColor = kWhiteBackgroundColor,
    this.backgroundColor = Colors.transparent,
    this.onPressed,
    this.padding,
    this.boxShadow = const [
      BoxShadow(
          //color: Colors.grey.withOpacity(0.5),
          // spreadRadius: 5,
          // blurRadius: 7,
          // offset: Offset(0, 3), // changes position of shadow
          ),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding == null ? sPadding : padding,
      decoration: BoxDecoration(
          color: backgroundColor, shape: BoxShape.circle, boxShadow: boxShadow),
      child: Column(
        children: [
          Icon(
            iconData,
            color: iconColor,
          ),
        ],
      ),
    );
  }
}
