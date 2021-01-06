

import 'package:flutter/material.dart';

class KButton extends StatelessWidget {
  final Function onPressed;
  final bool loading;
  final String text;
  final bool success;

  const KButton(
      {Key key,
      this.onPressed,
      this.loading = false,
      @required this.text,
      this.success = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: success ? 1 : (loading ? 0 : 1)),
        duration: Duration(milliseconds: 400),
        curve: Curves.easeIn,
        builder: (BuildContext context, double value, Widget child) {
          return Center(
            child: Container(
              height: 44,
              width: success
                  ? 100
                  : (MediaQuery.of(context).size.width - 100) * value + 100,
              child: RaisedButton(
                child: success
                    ? icon(value)
                    : (!loading || value > 0.5)
                        ? Text(
                            text,
                            style: TextStyle(
                                color: Colors.white.withOpacity(value)),
                          )
                        : progressIndicator(1 - value),
                onPressed: (loading || success) ? () {} : onPressed,
              ),
            ),
          );
        });
  }

  Widget icon(double value) => Container(
        child: Center(
          child: Icon(
            Icons.done,
            size: 24 * value,
            color: Colors.white,
          ),
        ),
      );

  Widget progressIndicator(double opacity) => Container(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          backgroundColor: Colors.white30,
          valueColor:
              AlwaysStoppedAnimation<Color>(Colors.white.withOpacity(opacity)),
        ),
      );
}
