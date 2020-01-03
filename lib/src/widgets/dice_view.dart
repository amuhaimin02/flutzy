import 'package:flutter/material.dart';
import 'package:flutzy/src/models/dice.dart';

class DiceView extends StatelessWidget {
  final Dice dice;

  const DiceView(this.dice, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      shadowColor: Colors.white,
      child: Container(
        width: 72,
        height: 72,
        child: dice != null
            ? Stack(
                children: dotsPlacement[dice].map((alignment) {
                  return Align(
                    alignment: alignment,
                    child: DiceDot(),
                  );
                }).toList(),
              )
            : SizedBox(),
      ),
    );
  }

  static const dotsPlacement = {
    Dice.one: [Alignment(0, 0)],
    Dice.two: [Alignment(-0.5, -0.5), Alignment(0.5, 0.5)],
    Dice.three: [Alignment(-0.5, -0.5), Alignment(0, 0), Alignment(0.5, 0.5)],
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
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      color: Colors.black54,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 10,
        height: 10,
      ),
    );
  }
}
