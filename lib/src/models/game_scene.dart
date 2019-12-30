import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutzy/src/models/score_type.dart';

class GameScene with ChangeNotifier {
  /// Random number generator used for the game
  final _random = Random();

  /// Total score of the current session
  int totalScore = 0;

  /// All the previous user move lists
  final List<ScoreType> moveList = [];

  void increment() {
    totalScore += 5 + _random.nextInt(15);
    notifyListeners();
  }

  // TODO: Return some value e.g. status
  void scoreIn(ScoreType type) {
    moveList.add(type);
  }

  void reset() {
    totalScore = 0;
    moveList.clear();
    notifyListeners();
  }
}
