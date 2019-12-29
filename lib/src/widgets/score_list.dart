import 'package:flutter/material.dart';
import 'package:flutzy/src/models/score_type.dart';
import 'package:flutzy/src/widgets/score_tile.dart';

class ScorePanelList extends StatelessWidget {
  final void Function(ScoreType) onTap;

  const ScorePanelList({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              for (final score in upperBoundScores) _scoreTile(score),
              ListTile(
                title: Text('Bonus:'),
                trailing: Text('12/63'),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              for (final score in lowerBoundScores) _scoreTile(score),
            ],
          ),
        ),
      ],
    );
  }

  Widget _scoreTile(ScoreType type) {
    return ScorePanelTile(
      type: type,
      onTap: () => _onTileSelected(type),
    );
  }

  void _onTileSelected(ScoreType type) {
    onTap(type);
  }
}
