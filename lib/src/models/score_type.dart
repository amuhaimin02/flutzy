enum ScoreType {
  ones,
  twos,
  threes,
  fours,
  fives,
  sixes,
  threeOfAKind,
  fourOfAKind,
  fullHouse,
  fiveOfAKind,
  smallStraight,
  largeStraight,
  chance,
}

const upperBoundScores = [
  ScoreType.ones,
  ScoreType.twos,
  ScoreType.threes,
  ScoreType.fours,
  ScoreType.fives,
  ScoreType.sixes,
];

const lowerBoundScores = [
  ScoreType.threeOfAKind,
  ScoreType.fourOfAKind,
  ScoreType.fullHouse,
  ScoreType.smallStraight,
  ScoreType.largeStraight,
  ScoreType.fiveOfAKind,
  ScoreType.chance,
];
