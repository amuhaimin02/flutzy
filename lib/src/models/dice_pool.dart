import 'dart:math';

import 'package:meta/meta.dart';

import 'dice.dart';

class DicePool {
  /// Random number generator used for the game
  final _random = Random();

  final int size;

  List<Dice> _content;

  List<Dice> get content => _content;

  List<bool> _diceOnHold;

  List<bool> get diceOnHold => _diceOnHold;

  static final emptyDicePool = List<Dice>(5);

  DicePool({@required this.size}) {
    clear();
  }

  List<Dice> roll() {
//    return _content = List.unmodifiable(List.generate(
//      size,
//      (i) => _diceOnHold[i] ? _content[i] : Dice.values[_random.nextInt(6)],
//    ));
    return _content = _random.nextBool()
        ? [Dice.five, Dice.five, Dice.five, Dice.five, Dice.five]
        : [Dice.one, Dice.two, Dice.three, Dice.five, Dice.six];
  }

  bool toggleHold(int index) {
    assert(index >= 0 && index < size);
    return _diceOnHold[index] = !_diceOnHold[index];
  }

  void clear() {
    _content = emptyDicePool;
    _diceOnHold = List.filled(size, false);
  }
}
