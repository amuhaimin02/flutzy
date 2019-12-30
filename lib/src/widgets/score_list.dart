import 'package:flutter/material.dart';
import 'package:flutzy/src/models/game_scene.dart';
import 'package:flutzy/src/models/score_type.dart';
import 'package:flutzy/src/widgets/score_tile.dart';
import 'package:provider/provider.dart';

class ScorePanelList extends StatelessWidget {
  final void Function(ScoreType) onTap;

  const ScorePanelList({Key key, this.onTap}) : super(key: key);

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
    final scene = Provider.of<GameScene>(context);
    return ScorePanelTile(
      type: type,
      enabled: !scene.moveList.contains(type),
      onTap: () => _onTileSelected(type),
    );
  }

  Widget _bonusSectionTile(BuildContext context) {
    return Container(
      color: Colors.yellow.shade200,
      child: ListTile(
        title: Text('Bonus:'),
        trailing: Text('12/63'),
      ),
    );
  }

  void _onTileSelected(ScoreType type) {
    onTap(type);
  }
}
