import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutzy/src/models/game_scene.dart';
import 'package:flutzy/src/models/score_type.dart';
import 'package:flutzy/src/utils/constants.dart';
import 'package:flutzy/src/widgets/score_list.dart';
import 'package:flutzy/src/widgets/total_score_indicator.dart';
import 'package:provider/provider.dart';

class FlutzyScoreBoard extends StatefulWidget {
  final VoidCallback onHeaderTap;
  final VoidCallback onDonePick;

  const FlutzyScoreBoard({Key key, this.onHeaderTap, this.onDonePick})
      : super(key: key);

  @override
  _FlutzyScoreBoardState createState() => _FlutzyScoreBoardState();
}

class _FlutzyScoreBoardState extends State<FlutzyScoreBoard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          _topBar(context),
          _scoreList(context),
          _confirmButtonBar(context),
        ],
      ),
    );
  }

  Widget _topBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: scoreIndicatorHeight,
      color: Theme.of(context).bottomAppBarColor,
      child: Consumer<GameScene>(
        builder: (context, scene, child) {
          return TotalScoreIndicator(
            score: scene.totalScore,
            onTap: widget.onHeaderTap ?? () {},
          );
        },
      ),
    );
  }

  Widget _scoreList(BuildContext context) {
    final scene = Provider.of<GameScene>(context);
    return ScorePanelList(
      scene: scene,
      onTap: scene.hasRolled ? (type) => _onScoreSelected(context, type) : null,
    );
  }

  Widget _confirmButtonBar(BuildContext context) {
    final scene = Provider.of<GameScene>(context, listen: false);
    final hasRolled = scene.hasRolled;
    return Container(
      height: 56,
      width: double.infinity,
      color: hasRolled ? Colors.black12 : Colors.red[600],
      alignment: Alignment.center,
      child: hasRolled
          ? Text('Choose a score to end your turn')
          : Text(
              'You must roll first before scoring in',
              style: TextStyle(color: Colors.white),
            ),
    );
  }

  // Static variable to prevent two simultaenous touch
  static bool _lock = false;

  void _onScoreSelected(BuildContext context, ScoreType type) async {
    final scene = Provider.of<GameScene>(context, listen: false);
    if (scene.hasRolled && !_lock) {
      _lock = true;
      HapticFeedback.mediumImpact();
      scene.scoreIn(type);
      await Future.delayed(autoSlideDownDuration);
      widget.onDonePick?.call();
      await Future.delayed(standardFadeDuration);
      scene.nextTurn();
      _lock = false;
    }
  }
}
