import 'package:bakery/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

enum ToastState { SUCCESS, ERROR, WARNING, INFO }

class KToast extends StatelessWidget {
  final String message;
  final Color color;

  const KToast({Key key, @required this.message, this.color}) : super(key: key);

  static ToastFuture s(String message, {Duration duration}) =>
      show(message, state: ToastState.SUCCESS, duration: duration);

  static ToastFuture e(String message, {Duration duration}) =>
      show(message, state: ToastState.ERROR, duration: duration);

  static ToastFuture w(String message, {Duration duration}) =>
      show(message, state: ToastState.WARNING, duration: duration);
  static ToastFuture show(String message,
      {ToastState state, Duration duration}) {
    Color color = Colors.green;
    if (state != null) {
      switch (state) {
        case ToastState.SUCCESS:
          color = Colors.green;
          break;
        case ToastState.ERROR:
          color = Colors.red;
          break;
        case ToastState.WARNING:
          color = Colors.orange;
          break;
        case ToastState.INFO:
          color = kPrimaryColor;
          break;
      }
    }

    return showToastWidget(KToast(message: message, color: color),
        position: ToastPosition.bottom,
        animationCurve: Curves.easeIn,
        dismissOtherToast: true,
        duration: duration);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: color ?? Colors.green,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 4,
            color: (color ?? Colors.green).withOpacity(0.5),
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRect(child: Text(message, textAlign: TextAlign.center)),
    );
  }
}
