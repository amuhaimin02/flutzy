import 'package:meta/meta.dart';

@immutable
class Dice {
  const Dice({@required this.value});

  final int value;

  static const one = Dice(value: 1);
  static const two = Dice(value: 2);
  static const three = Dice(value: 3);
  static const four = Dice(value: 4);
  static const five = Dice(value: 5);
  static const six = Dice(value: 6);

  static const values = [one, two, three, four, five, six];

  @override
  toString() => '[$value]';

  static List<Dice> from(List<int> integers) {
    return integers.map((i) => values[i - 1]).toList();
  }
}
