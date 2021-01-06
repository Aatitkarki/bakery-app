import 'package:flutter/material.dart';

class RectangularIconWidget extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final Color color;
  final EdgeInsets margin;

  const RectangularIconWidget(
      {Key key, this.height, this.child, this.color, this.width, this.margin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin != null ? margin : EdgeInsets.all(0),
      height: height,
      width: width == null ? height : width,
      color: color,
      child: child,
    );
  }
}
