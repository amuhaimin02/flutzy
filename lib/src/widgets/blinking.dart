import 'package:flutter/material.dart';

class Blinking extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const Blinking({
    Key key,
    this.child,
    this.duration = const Duration(milliseconds: 700),
  }) : super(key: key);

  @override
  _BlinkingState createState() => _BlinkingState();
}

class _BlinkingState extends State<Blinking>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: widget.child,
    );
  }
}
