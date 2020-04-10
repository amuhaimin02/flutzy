import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutzy/src/models/game_scene.dart';
import 'package:flutzy/src/utils/constants.dart';
import 'package:flutzy/src/utils/services.dart';
import 'package:flutzy/src/widgets/swipe_detector.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'play_table.dart';
import 'score_board.dart';

var isMobile = false;

class FlutzyMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameScene(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return constraints.maxWidth > 800
              ? FlutzyWebScreen()
              : FlutzyMobileScreen();
        },
      ),
    );
  }
}

class FlutzyMobileScreen extends StatefulWidget {
  @override
  _FlutzyMobileScreenState createState() => _FlutzyMobileScreenState();
}

class _FlutzyMobileScreenState extends State<FlutzyMobileScreen> {
  final _panel = PanelController();

  @override
  void initState() {
    super.initState();
    isMobile = true;
    audioPlayer.load('dice-throw.wav');
  }

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
//    final statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(context),
      body: SlidingUpPanel(
        controller: _panel,
        backdropEnabled: true,
        // TODO: This should not be calculated like this.
        // Figure out how to retrieve score list's height to put in here.
        minHeight: scoreIndicatorHeight,
        maxHeight: scoreIndicatorHeight + 7 * (scoreTileHeight + 1) + 56,
        body: Container(
          padding: EdgeInsets.only(
            bottom: scoreIndicatorHeight,
          ),
          child: SwipeDetector(
            onSwipeUp: _openScorePanel,
            onSwipeDown: () {},
            child: FlutzyPlayTable(),
          ),
        ),
        panel: FlutzyScoreBoard(
          onHeaderTap: _togglePanelSliding,
          onDonePick: _closeScorePanel,
        ),
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(72),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black54,
        ),
        actions: [
          IconButton(
            tooltip: 'Restart',
            icon: Icon(Icons.refresh),
            onPressed: () {
              Provider.of<GameScene>(context, listen: false).restart();
            },
          ),
        ],
      ),
    );
  }

  Future<bool> _onBackPress() async {
    if (_panel.isPanelOpen) {
      _panel.close();
      return false;
    } else {
      return true;
    }
  }

  void _togglePanelSliding() {
    if (_panel.isPanelOpen) {
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

class FlutzyWebScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _screenScaffold(context);
  }

  Widget _screenScaffold(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(context),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 360,
            child: FlutzyPlayTable(),
          ),
          Card(
            child: Container(
              // TODO: If possible I don't want to hard code the value like this
              width: 420,
              height: scoreIndicatorHeight + 7 * (scoreTileHeight + 1) + 56,
              child: FlutzyScoreBoard(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black54,
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
}
