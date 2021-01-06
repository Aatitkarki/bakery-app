import 'package:flutter/material.dart';

class ItemValueWidget extends StatelessWidget {
  final String title;
  final String value;
  final TextStyle titleTextStyle;
  final TextStyle valueTextStyle;

  const ItemValueWidget(
      {this.title, this.value, this.titleTextStyle, this.valueTextStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: titleTextStyle,
        ),
        Text(
          value,
          style: valueTextStyle,
        )
      ],
    );
  }
}
