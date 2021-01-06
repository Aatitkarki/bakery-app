import 'package:flutter/material.dart';

class KTextLink extends StatelessWidget {
  final String text;
  final Function onTap;
  final TextStyle style;
  final EdgeInsets padding;
  final TextAlign textAlign;

  const KTextLink(this.text,
      {Key key, this.onTap, this.style, this.padding, this.textAlign})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        color: Colors.transparent,
        child: Text(
          text,
          style: style ??
              TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
          textAlign: textAlign,
        ),
      ),
    );
  }
}
