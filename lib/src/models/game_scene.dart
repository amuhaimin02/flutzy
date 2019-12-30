import 'package:flutter/cupertino.dart';
import 'package:flutzy/src/models/dice_pool.dart';
import 'package:flutzy/src/models/score_type.dart';

class GameScene with ChangeNotifier {
  /// All the previous user move lists
  final List<ScoreType> moveList = [];

  final dicePool = DicePool(count: 5);

  int _round = 1;
  int get round => _round;

  /// Total score of the current session
  int _totalScore = 0;
  int get totalScore => _totalScore;

  bool canRoll() {
    return true;
  }

  void roll() {
    dicePool.roll();
    notifyListeners();
  }

  // TODO: Return some value e.g. status
  void scoreIn(ScoreType type) {
    final sum = dicePool.content?.fold(0, (value, sum) => sum + value) ?? 0;
    moveList.add(type);
    _totalScore += sum;
    notifyListeners();
  }

  void nextTurn() {
    _round++;
    dicePool.clear();
    notifyListeners();
  }

  void restart() {
    _round = 1;
    _totalScore = 0;
    dicePool.clear();
    moveList.clear();
    notifyListeners();
  }
}
