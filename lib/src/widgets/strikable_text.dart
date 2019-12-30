import 'package:flutter/material.dart';

// https://gist.github.com/maksimr/7ad40fbe3f16329dd0bb548976150f8a

class AnimatedStrikableText extends StatefulWidget {
  final String text;
  final TextStyle style;

  final bool strike;
  final Color lineColor;
  final double thickness;

  const AnimatedStrikableText(
    this.text, {
    Key key,
    this.style,
    this.strike = false,
    this.lineColor = Colors.grey,
    this.thickness = 1,
  }) : super(key: key);

  @override
  _AnimatedStrikableTextState createState() => _AnimatedStrikableTextState();
}

class _AnimatedStrikableTextState extends State<AnimatedStrikableText>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
    // We would use linear curve. Remove it
    _animation = CurvedAnimation(curve: Curves.linear, parent: _controller);
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedStrikableText oldWidget) {
    if (widget.strike) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          widget.text,
          style: widget.style,
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) => Transform(
            transform: Matrix4.identity()..scale(_animation.value, 1.0),
            child: child,
          ),
          child: _strikedText(),
        ),
      ],
    );
  }

  Widget _strikedText() {
    return Text(
      widget.text,
      style: widget.style.copyWith(
        color: Colors.transparent,
        decoration: TextDecoration.lineThrough,
        decorationColor: widget.lineColor,
        decorationThickness: widget.thickness,
      ),
    );
  }
}
