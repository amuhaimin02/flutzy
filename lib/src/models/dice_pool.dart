import 'dart:math';

import 'package:meta/meta.dart';

class DicePool {
  /// Random number generator used for the game
  final _random = Random();

  final int count;
  List<int> content;

  DicePool({@required this.count});

  List<int> roll() {
    return content =
        List.generate(count, (_) => _random.nextInt(6) + 1, growable: false);
  }

  void clear() {
    content = null;
  }
}
