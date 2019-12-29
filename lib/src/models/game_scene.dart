import 'dart:math';

import 'package:flutter/cupertino.dart';

class GameScene with ChangeNotifier {
  final _random = Random();

  int totalScore = 0;

  void increment() {
    totalScore += 5 + _random.nextInt(15);
    notifyListeners();
  }

  void reset() {
    totalScore = 0;
    notifyListeners();
  }
}
