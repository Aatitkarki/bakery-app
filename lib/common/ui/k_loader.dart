import 'dart:math' as math;

import 'package:flutter/material.dart';

class KLoader extends ProgressIndicator {
  final double size;
  final Duration duration;

  const KLoader({
    Key key,
    Color color,
    String semanticsLabel,
    String semanticsValue,
    this.size = 48,
    this.duration = const Duration(milliseconds: 900),
  }) : super(
          key: key,
          backgroundColor: color,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        );

  @override
  _KLoaderState createState() => _KLoaderState();
}

class _KLoaderState extends State<KLoader> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _curvedAnimation;

  Color color;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack);

    // if (widget.value == null)

    _controller.repeat();

    color = widget.backgroundColor ?? Theme.of(context).primaryColor;
  }

  @override
  void didUpdateWidget(KLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value == null && !_controller.isAnimating)
      _controller.repeat();
    else if (widget.value != null && _controller.isAnimating)
      _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curvedAnimation,
      builder: (BuildContext context, Widget child) {
        return Transform.rotate(
          angle: -math.pi * _controller.value,
          child: child,
        );
      },
      child: Icon(
        Icons.settings,
        size: widget.size,
        color: color,
      ),
    );
  }

  Widget build3(BuildContext context) {
    return AnimatedBuilder(
      animation: _curvedAnimation,
      builder: (BuildContext context, Widget child) {
        return Stack(
          children: <Widget>[
            Container(
              width: widget.size * 1.75,
              height: widget.size * 2,
            ),
            Positioned(
              top: widget.size * 0.5,
              child: Transform.rotate(
                angle: -math.pi * _controller.value,
                child: Icon(
                  Icons.settings,
                  size: widget.size,
                  color: color,
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Transform.rotate(
                angle: math.pi * _controller.value,
                child: Transform.rotate(
                  angle: math.pi * 0.5,
                  child: Icon(
                    Icons.settings,
                    size: widget.size,
                    color: color,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Transform.rotate(
                angle: math.pi * _controller.value,
                child: Transform.rotate(
                  angle: math.pi * 0.5,
                  child: Icon(
                    Icons.settings,
                    size: widget.size,
                    color: color,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
