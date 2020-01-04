import 'package:flutter/material.dart';
import 'package:flutzy/src/models/dice.dart';
import 'package:flutzy/src/utils/constants.dart';

class DiceView extends StatelessWidget {
  final Dice dice;
  final Color faceColor;
  final Color dotColor;

  const DiceView(
    this.dice, {
    Key key,
    this.faceColor = Colors.white,
    this.dotColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shadowColor: Colors.black38,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: fastFadeDuration,
        width: diceFaceSize,
        height: diceFaceSize,
        decoration: BoxDecoration(
          color: faceColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: dice != null
            ? Stack(
                children: dotsPlacement[dice].map((alignment) {
                  return Align(
                    alignment: alignment,
                    child: DiceDot(
                      color: dotColor,
                    ),
                  );
                }).toList(),
              )
            : SizedBox(),
      ),
    );
  }

  static const dotsPlacement = {
    Dice.one: [Alignment(0, 0)],
    Dice.two: [Alignment(-0.5, 0.5), Alignment(0.5, -0.5)],
    Dice.three: [Alignment(-0.5, 0.5), Alignment(0, 0), Alignment(0.5, -0.5)],
    Dice.four: [
      Alignment(-0.5, -0.5),
      Alignment(-0.5, 0.5),
      Alignment(0.5, 0.5),
      Alignment(0.5, -0.5)
    ],
    Dice.five: [
      Alignment(-0.5, -0.5),
      Alignment(-0.5, 0.5),
      Alignment(0, 0),
      Alignment(0.5, 0.5),
      Alignment(0.5, -0.5),
    ],
    Dice.six: [
      Alignment(-0.5, -0.5),
      Alignment(-0.5, 0),
      Alignment(-0.5, 0.5),
      Alignment(0.5, -0.5),
      Alignment(0.5, 0),
      Alignment(0.5, 0.5),
    ],
  };
}

class DiceDot extends StatelessWidget {
  final Color color;

  const DiceDot({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: color,
      shadowColor: Colors.black38,
      borderRadius: BorderRadius.circular(diceDotSize),
      child: Container(
        width: diceDotSize * 2,
        height: diceDotSize * 2,
      ),
    );
  }
}
