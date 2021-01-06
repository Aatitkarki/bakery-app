import 'package:flutter/widgets.dart';

class KLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "kLogo",
      width: MediaQuery.of(context).size.width,
    );
  }
}
