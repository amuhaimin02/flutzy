import 'package:flutter/material.dart';

// https://stackoverflow.com/questions/55787710/detect-vertical-swipe-direction-in-flutter

class SwipeDetector extends StatefulWidget {
  final Function() onSwipeUp;
  final Function() onSwipeDown;
  final Widget child;

  SwipeDetector({this.onSwipeUp, this.onSwipeDown, this.child});

  @override
  _SwipeDetectorState createState() => _SwipeDetectorState();
}

class _SwipeDetectorState extends State<SwipeDetector> {
  //Vertical drag details
  DragStartDetails startVerticalDragDetails;
  DragUpdateDetails updateVerticalDragDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragStart: (dragDetails) {
        startVerticalDragDetails = dragDetails;
      },
      onVerticalDragUpdate: (dragDetails) {
        updateVerticalDragDetails = dragDetails;
      },
      onVerticalDragEnd: (endDetails) {
        double dx = updateVerticalDragDetails.globalPosition.dx -
            startVerticalDragDetails.globalPosition.dx;
        double dy = updateVerticalDragDetails.globalPosition.dy -
            startVerticalDragDetails.globalPosition.dy;
        double velocity = endDetails.primaryVelocity;

        //Convert values to be positive
        if (dx < 0) dx = -dx;
        if (dy < 0) dy = -dy;

        if (velocity < 0) {
          widget.onSwipeUp();
        } else {
          widget.onSwipeDown();
        }
      },
      child: widget.child,
    );
  }
}
