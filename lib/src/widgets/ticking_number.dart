import 'package:flutter/material.dart';

// https://stackoverflow.com/questions/43916323/how-do-i-create-an-animated-number-counter
class TickingNumber extends ImplicitlyAnimatedWidget {
  final int number;
  final TextStyle style;

  TickingNumber(
    this.number, {
    Key key,
    this.style,
    @required Duration duration,
    Curve curve = Curves.linear,
  }) : super(key: key, duration: duration, curve: curve);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedCountState();
}

class _AnimatedCountState extends AnimatedWidgetBaseState<TickingNumber> {
  IntTween _number;

  @override
  Widget build(BuildContext context) {
    return Text(
      _number.evaluate(animation).toString(),
      style: widget.style,
    );
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    _number =
        visitor(_number, widget.number, (value) => IntTween(begin: value));
  }
}
