import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutzy/src/models/game_scene.dart';
import 'package:flutzy/src/models/score_type.dart';
import 'package:flutzy/src/widgets/score_list.dart';
import 'package:flutzy/src/widgets/total_score_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

const scoreIndicatorHeight = 120.0;

class FlutzyMainScreen extends StatefulWidget {
  @override
  _FlutzyMainScreenState createState() => _FlutzyMainScreenState();
}

class _FlutzyMainScreenState extends State<FlutzyMainScreen> {
  final _panel = PanelController();

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    return ChangeNotifierProvider(
      create: (context) => GameScene(),
      child: WillPopScope(
        onWillPop: _onBackPress,
        child: Scaffold(
          body: SlidingUpPanel(
            controller: _panel,
            backdropEnabled: true,
            // TODO: Change this hard coded values
            minHeight: scoreIndicatorHeight,
            maxHeight: scoreIndicatorHeight + 7 * 56.0 + 56,
            body: Container(
              padding: EdgeInsets.only(
                top: statusBarHeight,
                bottom: scoreIndicatorHeight,
              ),
              child: YatzyPlayTable(),
            ),
            panel: FlutzyScoreBoard(
              onHeaderTap: _togglePanelSliding,
              onDonePick: _closeScorePanel,
            ),
          ),
        ),
      ),
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

  void _closeScorePanel() {
    _panel.close();
  }
}

class FlutzyScoreBoard extends StatelessWidget {
  final VoidCallback onHeaderTap;
  final VoidCallback onDonePick;

  const FlutzyScoreBoard({Key key, this.onHeaderTap, this.onDonePick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: scoreIndicatorHeight,
            color: Theme.of(context).bottomAppBarColor,
            child: Consumer<GameScene>(
              builder: (context, scene, child) {
                return TotalScoreIndicator(
                  score: scene.totalScore,
                  onTap: onHeaderTap,
                );
              },
            ),
          ),
          ScorePanelList(
            onTap: (type) => _onScoreSelected(context, type),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 56,
              width: double.infinity,
              color: Colors.black12,
              alignment: Alignment.center,
              child: Text('Confirm'),
            ),
          )
        ],
      ),
    );
  }

  void _onScoreSelected(BuildContext context, ScoreType type) {
    HapticFeedback.mediumImpact();
    print(type);
    Provider.of<GameScene>(context, listen: false).increment();
    Future.delayed(Duration(seconds: 1), onDonePick);
  }
}

class YatzyPlayTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 200,
            height: 200,
            color: Colors.white54,
          ),
          SizedBox(height: 40),
          _buildRollButton(context),
          SizedBox(height: 8),
          _buildScoreInButton(context),
        ],
      ),
    );
  }

  Widget _buildRollButton(BuildContext context) {
    return RaisedButton.icon(
      icon: Icon(MdiIcons.diceMultipleOutline),
      label: Text('Roll'),
      onPressed: () {
        Provider.of<GameScene>(context, listen: false).reset();
      },
    );
  }

  Widget _buildScoreInButton(BuildContext context) {
    return FlatButton(
      child: Text('Score in'),
      onPressed: () {},
    );
  }
}
