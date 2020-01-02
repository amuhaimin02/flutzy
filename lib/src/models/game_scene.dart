import 'package:flutter/cupertino.dart';
import 'package:flutzy/src/models/dice_pool.dart';
import 'package:flutzy/src/models/score_type.dart';

class GameScene with ChangeNotifier {
  /// All the previous user move lists
  final List<Move> moveList = [];

  final dicePool = DicePool(size: 5);
  final maxTries = 3;

  bool _turnEnded = false;

  bool get turnEnded => _turnEnded;

  int _round = 1;

  int get round => _round;

  int _tries = 0;

  int get tries => _tries;

  /// Total score of the current session
  int _totalScore = 0;

  int get totalScore => _totalScore;

  bool get hasRolled => tries > 0;

  bool get canRoll => _tries < maxTries;

  void roll() {
    dicePool.roll();
    _tries++;
    notifyListeners();
  }

  // TODO: Return some value e.g. status
  void scoreIn(ScoreType type) {
    final score = type.score(dicePool.content);
    moveList.add(Move(type, score));
    _totalScore += score;
    _turnEnded = true;
    notifyListeners();
  }

  void nextTurn() {
    _round++;
    _tries = 0;
    dicePool.clear();
    _turnEnded = false;
    notifyListeners();
  }

  void restart() {
    _round = 1;
    _tries = 0;
    _totalScore = 0;
    dicePool.clear();
    moveList.clear();
    notifyListeners();
  }
}

@immutable
class Move {
  final ScoreType type;
  final int score;

  Move(this.type, this.score);
}
