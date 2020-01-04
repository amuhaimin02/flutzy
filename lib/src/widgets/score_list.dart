import 'package:flutter/material.dart';
import 'package:flutzy/src/models/game_scene.dart';
import 'package:flutzy/src/models/score_type.dart';
import 'package:flutzy/src/widgets/score_tile.dart';
import 'package:flutzy/src/widgets/section_bonus_tile.dart';

class ScorePanelList extends StatelessWidget {
  final void Function(ScoreType) onTap;
  final GameScene scene;

  const ScorePanelList({Key key, this.onTap, this.scene}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _upperBoundSublist(context),
          ),
          VerticalDivider(width: 1),
          Expanded(
            child: _lowerBoundSublist(context),
          ),
        ],
      ),
    );
  }

  Widget _lowerBoundSublist(BuildContext context) {
    return Column(
      children: [
        for (final score in lowerBoundScores) ...[
          _scoreTile(context, score),
          Divider(height: 1),
        ]
      ],
    );
  }

  Widget _upperBoundSublist(BuildContext context) {
    return Column(
      children: [
        for (final score in upperBoundScores) ...[
          _scoreTile(context, score),
          Divider(height: 1),
        ],
        _bonusSectionTile(context),
        Divider(height: 1),
      ],
    );
  }

  Widget _scoreTile(BuildContext context, ScoreType type) {
    final hasRolled = scene.hasRolled;
    final move = scene.moveList
        .firstWhere((move) => move.type == type, orElse: () => null);

    return ScorePanelTile(
      type: type,
      enabled: move == null,
      score: move?.score,
      hintScore: hasRolled ? type.score(scene.dicePool.content) : null,
      onTap: onTap != null ? () => _onTileSelected(type) : null,
    );
  }

  Widget _bonusSectionTile(BuildContext context) {
    return SectionBonusTile(
      currentScore: scene.upperBoundScore,
      maxScore: 63,
    );
  }

  void _onTileSelected(ScoreType type) {
    onTap(type);
  }
}
