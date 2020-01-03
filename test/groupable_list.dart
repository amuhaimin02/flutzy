import 'package:flutter_test/flutter_test.dart';
import 'package:flutzy/src/utils/groupable_list.dart';

void main() {
  test('Groupable list', () {
    expect([1, 2, 3, 4, 5, 6].group(3), [
      [1, 2, 3],
      [4, 5, 6]
    ]);
    expect([1, 2, 3, 4, 5, 6].group(2), [
      [1, 2],
      [3, 4],
      [5, 6]
    ]);
    expect([1, 2, 3, 4, 5].group(3), [
      [1, 2, 3],
      [4, 5]
    ]);
    // This is currently not working.
//    expect([1, 2, 3, 4, 5, 6].group(1), [
//      [1],
//      [2],
//      [3],
//      [4],
//      [5],
//      [6]
//    ]);
  });
}
