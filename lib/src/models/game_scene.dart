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
  int _upperBoundScore = 0;

  int get upperBoundScore => _upperBoundScore;

  int _lowerBoundScore = 0;

  int get lowerBoundScore => _lowerBoundScore;

  int get sectionBonus => _upperBoundScore >= 63 ? 35 : 0;

  int get totalScore => upperBoundScore + lowerBoundScore + sectionBonus;

  bool get hasRolled => tries > 0;

  bool get canRoll => _tries < maxTries;

  void roll() {
    dicePool.roll();
    _tries++;
    notifyListeners();
  }

  void toggleHold(int index) {
    dicePool.toggleHold(index);
    notifyListeners();
  }

  // TODO: Return some value e.g. status
  void scoreIn(ScoreType type) {
    final score = type.score(dicePool.content);
    moveList.add(Move(type, score));
    if (upperBoundScores.contains(type)) {
      _upperBoundScore += score;
    } else {
      _lowerBoundScore += score;
    }
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
    _upperBoundScore = 0;
    _lowerBoundScore = 0;
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
