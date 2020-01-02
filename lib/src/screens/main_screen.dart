import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutzy/src/models/dice.dart';
import 'package:flutzy/src/models/game_scene.dart';
import 'package:flutzy/src/models/score_type.dart';
import 'package:flutzy/src/widgets/constants.dart';
import 'package:flutzy/src/widgets/score_list.dart';
import 'package:flutzy/src/widgets/swipe_detector.dart';
import 'package:flutzy/src/widgets/total_score_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

const scoreIndicatorHeight = 120.0;

class FlutzyMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameScene(),
      child: FlutzyScreenContent(),
    );
  }
}

class FlutzyScreenContent extends StatefulWidget {
  @override
  _FlutzyScreenContentState createState() => _FlutzyScreenContentState();
}

class _FlutzyScreenContentState extends State<FlutzyScreenContent> {
  final _panel = PanelController();

  @override
  Widget build(BuildContext context) {
    return Selector<GameScene, bool>(
      selector: (_, scene) => scene.turnEnded,
      builder: (_, turnEnded, __) {
        return WillPopScope(
          onWillPop: _onBackPress,
          child: IgnorePointer(
            ignoring: turnEnded,
            child: _screenScaffold(),
          ),
        );
      },
    );
  }

  Widget _screenScaffold() {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(),
      body: SlidingUpPanel(
        controller: _panel,
        backdropEnabled: true,
        // TODO: This should not be calculated like this.
        // Figure out how to retrieve score list's height to put in here.
        minHeight: scoreIndicatorHeight,
        maxHeight: scoreIndicatorHeight + 7 * (scoreTileHeight + 1) + 56,
        body: Container(
          padding: EdgeInsets.only(
            top: statusBarHeight,
            bottom: scoreIndicatorHeight,
          ),
          child: SwipeDetector(
            onSwipeUp: _openScorePanel,
            onSwipeDown: () {},
            child: YatzyPlayTable(
              onScoreInPressed: _openScorePanel,
            ),
          ),
        ),
        panel: FlutzyScoreBoard(
          onHeaderTap: _togglePanelSliding,
          onDonePick: _closeScorePanel,
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black87,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            Provider.of<GameScene>(context, listen: false).restart();
          },
        ),
      ],
    );
  }

  Future<bool> _onBackPress() async {
    if (_panel.isPanelOpen()) {
      _panel.close();
      return false;
    } else {
      return true;
    }
  }

  void _togglePanelSliding() {
    if (_panel.isPanelOpen()) {
      _panel.close();
    } else {
      _panel.open();
    }
  }

  void _openScorePanel() {
    _panel.open();
  }

  void _closeScorePanel() {
    _panel.close();
  }
}

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
            onTap: widget.onHeaderTap,
          );
        },
      ),
    );
  }

  Widget _scoreList(BuildContext context) {
    final scene = Provider.of<GameScene>(context);
    return ScorePanelList(
      scene: scene,
      onTap: (type) => _onScoreSelected(context, type),
    );
  }

  Widget _confirmButtonBar(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 56,
        width: double.infinity,
        color: Colors.black12,
        alignment: Alignment.center,
        child: Text('Confirm'),
      ),
    );
  }

  void _onScoreSelected(BuildContext context, ScoreType type) async {
    final scene = Provider.of<GameScene>(context, listen: false);
    HapticFeedback.mediumImpact();
    scene.scoreIn(type);
    await Future.delayed(autoSlideDownDuration);
    widget.onDonePick();
    await Future.delayed(Duration(milliseconds: 400));
    scene.nextTurn();
  }
}

class YatzyPlayTable extends StatelessWidget {
  // Instead of passing data like this, consider to
  // use other suitable method (Provider?)
  final VoidCallback onScoreInPressed;

  const YatzyPlayTable({Key key, this.onScoreInPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _diceDisplay(context),
          SizedBox(height: 40),
          _buildRollButton(context),
          SizedBox(height: 8),
          _buildScoreInButton(context),
        ],
      ),
    );
  }

  Widget _diceDisplay(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      color: Colors.white54,
      alignment: Alignment.center,
      child: Selector<GameScene, List<Dice>>(
        selector: (_, scene) => scene.dicePool.content,
        builder: (_, pool, __) {
          return Text(
            pool?.toString() ?? 'Dice not rolled yet',
          );
        },
      ),
    );
  }

  Widget _buildRollButton(BuildContext context) {
    final scene = Provider.of<GameScene>(context);
    return RaisedButton.icon(
      icon: Icon(MdiIcons.diceMultipleOutline),
      label: Text('Roll (${scene.tries}/${scene.maxTries})'),
      onPressed: scene.canRoll ? () => scene.roll() : null,
    );
  }

  Widget _buildScoreInButton(BuildContext context) {
    return Consumer<GameScene>(
      builder: (_, scene, __) {
        return AnimatedOpacity(
          opacity: scene.hasRolled ? 1 : 0,
          duration: Duration(milliseconds: 500),
          child: FlatButton(
            child: Text('Score in'),
            onPressed: scene.hasRolled ? onScoreInPressed : null,
          ),
        );
      },
    );
  }
}
