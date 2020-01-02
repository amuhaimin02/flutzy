import 'package:flutter_test/flutter_test.dart';
import 'package:flutzy/src/models/dice.dart';
import 'package:flutzy/src/models/score_type.dart';

void main() {
  group('Score calculation upper bound: ', () {
    test('Single dice', () {
      expect(ScoreType.ones.score(Dice.from([1, 2, 3, 4, 5])), 1);
      expect(ScoreType.twos.score(Dice.from([1, 2, 3, 4, 5])), 2);
      expect(ScoreType.threes.score(Dice.from([1, 2, 3, 4, 5])), 3);
      expect(ScoreType.fours.score(Dice.from([1, 2, 3, 4, 5])), 4);
      expect(ScoreType.fives.score(Dice.from([1, 2, 3, 4, 5])), 5);
    });
    test('Two and more dice', () {
      expect(ScoreType.ones.score(Dice.from([1, 1, 3, 4, 5])), 2);
      expect(ScoreType.twos.score(Dice.from([1, 2, 2, 2, 5])), 6);
      expect(ScoreType.threes.score(Dice.from([1, 2, 3, 3, 3])), 9);
      expect(ScoreType.fours.score(Dice.from([1, 4, 4, 4, 4])), 16);
      expect(ScoreType.fives.score(Dice.from([5, 5, 5, 5, 5])), 25);
    });
    test('No dice', () {
      expect(ScoreType.ones.score(Dice.from([1, 1, 1, 1, 5])), 4);
      expect(ScoreType.ones.score(Dice.from([2, 2, 3, 4, 5])), 0);
      expect(ScoreType.ones.score(Dice.from([5, 5, 5, 5, 5])), 0);
    });
  });
  group('Score calculation lower bound: ', () {
    test('Chances', () {
      expect(ScoreType.chance.score(Dice.from([1, 2, 3, 4, 5])), 15);
      expect(ScoreType.chance.score(Dice.from([4, 2, 6, 1, 5])), 18);
      expect(ScoreType.chance.score(Dice.from([1, 1, 1, 1, 1])), 5);
      expect(ScoreType.chance.score(Dice.from([6, 2, 4, 4, 1])), 17);
      expect(ScoreType.chance.score(Dice.from([5, 5, 5, 5, 5])), 25);
    });
    test('Three of a kind', () {
      expect(ScoreType.threeOfAKind.score(Dice.from([1, 2, 3, 4, 5])), 0);
      expect(ScoreType.threeOfAKind.score(Dice.from([2, 2, 3, 4, 5])), 0);
      expect(ScoreType.threeOfAKind.score(Dice.from([3, 3, 3, 4, 5])), 18);
      expect(ScoreType.threeOfAKind.score(Dice.from([4, 4, 4, 4, 5])), 21);
      expect(ScoreType.threeOfAKind.score(Dice.from([5, 5, 5, 5, 5])), 25);
      expect(ScoreType.threeOfAKind.score(Dice.from([5, 1, 5, 2, 5])), 18);
      expect(ScoreType.threeOfAKind.score(Dice.from([2, 5, 2, 2, 2])), 13);
      expect(ScoreType.threeOfAKind.score(Dice.from([1, 6, 3, 1, 1])), 12);
    });
    test('Four of a kind', () {
      expect(ScoreType.fourOfAKind.score(Dice.from([1, 2, 3, 4, 5])), 0);
      expect(ScoreType.fourOfAKind.score(Dice.from([2, 2, 3, 4, 5])), 0);
      expect(ScoreType.fourOfAKind.score(Dice.from([3, 3, 3, 4, 5])), 0);
      expect(ScoreType.fourOfAKind.score(Dice.from([4, 4, 4, 4, 5])), 21);
      expect(ScoreType.fourOfAKind.score(Dice.from([5, 5, 5, 5, 5])), 25);
      expect(ScoreType.fourOfAKind.score(Dice.from([3, 3, 3, 4, 3])), 16);
      expect(ScoreType.fourOfAKind.score(Dice.from([1, 5, 5, 5, 5])), 21);
    });
    test('Five of a kind', () {
      expect(ScoreType.fiveOfAKind.score(Dice.from([5, 5, 5, 5, 5])), 50);
      expect(ScoreType.fiveOfAKind.score(Dice.from([3, 3, 3, 3, 3])), 50);
      expect(ScoreType.fiveOfAKind.score(Dice.from([1, 1, 1, 1, 1])), 50);
      expect(ScoreType.fiveOfAKind.score(Dice.from([1, 2, 3, 4, 5])), 0);
      expect(ScoreType.fiveOfAKind.score(Dice.from([2, 2, 3, 4, 5])), 0);
      expect(ScoreType.fiveOfAKind.score(Dice.from([3, 3, 3, 4, 5])), 0);
      expect(ScoreType.fiveOfAKind.score(Dice.from([4, 4, 4, 4, 5])), 0);
    });
    test('Full house', () {
      expect(ScoreType.fullHouse.score(Dice.from([2, 2, 3, 3, 3])), 25);
      expect(ScoreType.fullHouse.score(Dice.from([1, 4, 4, 1, 4])), 25);
      expect(ScoreType.fullHouse.score(Dice.from([3, 4, 3, 3, 4])), 25);
      expect(ScoreType.fullHouse.score(Dice.from([1, 2, 3, 4, 5])), 0);
      expect(ScoreType.fullHouse.score(Dice.from([3, 3, 3, 4, 5])), 0);
      expect(ScoreType.fullHouse.score(Dice.from([3, 4, 3, 3, 5])), 0);
      expect(ScoreType.fullHouse.score(Dice.from([3, 4, 3, 5, 5])), 0);
    });
    test('Small straight', () {
      expect(ScoreType.smallStraight.score(Dice.from([1, 2, 3, 4, 5])), 30);
      expect(ScoreType.smallStraight.score(Dice.from([1, 2, 3, 4, 4])), 30);
      expect(ScoreType.smallStraight.score(Dice.from([1, 4, 3, 2, 4])), 30);
      expect(ScoreType.smallStraight.score(Dice.from([5, 2, 4, 3, 5])), 30);
      expect(ScoreType.smallStraight.score(Dice.from([5, 2, 3, 3, 1])), 0);
      expect(ScoreType.smallStraight.score(Dice.from([1, 2, 3, 5, 6])), 0);
      expect(ScoreType.smallStraight.score(Dice.from([6, 3, 1, 5, 2])), 0);
    });
    test('Large straight', () {
      expect(ScoreType.largeStraight.score(Dice.from([1, 2, 3, 4, 5])), 40);
      expect(ScoreType.largeStraight.score(Dice.from([5, 4, 3, 2, 1])), 40);
      expect(ScoreType.largeStraight.score(Dice.from([6, 2, 3, 5, 4])), 40);
      expect(ScoreType.largeStraight.score(Dice.from([2, 1, 5, 4, 3])), 40);
      expect(ScoreType.largeStraight.score(Dice.from([6, 4, 1, 5, 2])), 0);
      expect(ScoreType.largeStraight.score(Dice.from([1, 2, 3, 4, 6])), 0);
      expect(ScoreType.largeStraight.score(Dice.from([5, 2, 6, 1, 4])), 0);
    });
  });
}
