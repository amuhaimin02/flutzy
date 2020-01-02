//enum ScoreType {
//  ones,
//  twos,
//  threes,
//  fours,
//  fives,
//  sixes,
//  threeOfAKind,
//  fourOfAKind,
//  fullHouse,
//  fiveOfAKind,
//  smallStraight,
//  largeStraight,
//  chance,
//}

import 'dice.dart';

class ScoreType {
  static final ones = ScoreType(
    score: (dices) => _countDicesAndSumWhere(dices, Dice.one),
  );
  static final twos = ScoreType(
    score: (dices) => _countDicesAndSumWhere(dices, Dice.two),
  );
  static final threes = ScoreType(
    score: (dices) => _countDicesAndSumWhere(dices, Dice.three),
  );
  static final fours = ScoreType(
    score: (dices) => _countDicesAndSumWhere(dices, Dice.four),
  );
  static final fives = ScoreType(
    score: (dices) => _countDicesAndSumWhere(dices, Dice.five),
  );
  static final sixes = ScoreType(
    score: (dices) => _countDicesAndSumWhere(dices, Dice.six),
  );
  static final threeOfAKind = ScoreType(
    score: (dices) => 0,
  );
  static final fourOfAKind = ScoreType(
    score: (dices) => 0,
  );
  static final fullHouse = ScoreType(
    score: (dices) => 0,
  );
  static final smallStraight = ScoreType(
    score: (dices) => 0,
  );
  static final largeStraight = ScoreType(
    score: (dices) => 0,
  );
  static final fiveOfAKind = ScoreType(
    score: (dices) => 0,
  );
  static final chance = ScoreType(
    score: (dices) => dices.fold(0, (sum, d) => sum + d.value),
  );

  final int Function(List<Dice> dices) score;

  ScoreType({this.score});

  static int _countDicesAndSumWhere(List<Dice> dices, Dice dice) {
    return dices.where((d) => d == dice).length * dice.value;
  }
}

final upperBoundScores = [
  ScoreType.ones,
  ScoreType.twos,
  ScoreType.threes,
  ScoreType.fours,
  ScoreType.fives,
  ScoreType.sixes,
];

final lowerBoundScores = [
  ScoreType.threeOfAKind,
  ScoreType.fourOfAKind,
  ScoreType.fullHouse,
  ScoreType.smallStraight,
  ScoreType.largeStraight,
  ScoreType.fiveOfAKind,
  ScoreType.chance,
];
