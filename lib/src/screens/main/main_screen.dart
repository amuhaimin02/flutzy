import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutzy/src/models/game_scene.dart';
import 'package:flutzy/src/utils/constants.dart';
import 'package:flutzy/src/widgets/swipe_detector.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'play_table.dart';
import 'score_board.dart';

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
            child: FlutzyPlayTable(
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
