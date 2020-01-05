import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutzy/src/models/game_scene.dart';
import 'package:flutzy/src/screens/main/main_screen.dart';
import 'package:flutzy/src/utils/constants.dart';
import 'package:flutzy/src/widgets/blinking.dart';
import 'package:flutzy/src/widgets/dice_pool_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class FlutzyPlayTable extends StatelessWidget {
  const FlutzyPlayTable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Center(
            child: _playTableContent(context),
          ),
          if (isMobile) _swipeUpIndicatorMobile(context),
        ],
      ),
    );
  }

  Widget _playTableContent(BuildContext context) {
    final scene = Provider.of<GameScene>(context, listen: false);
    if (scene.isStillInGame) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _guideMessage(context),
            _diceDisplay(context),
            _buildRollButton(context),
          ],
        ),
      );
    } else {
      return _endingScreen(context);
    }
  }

  Widget _diceDisplay(BuildContext context) {
    final scene = Provider.of<GameScene>(context, listen: false);
    return DicePoolView(
      pool: scene.dicePool,
      onSelected: (index) {
        scene.toggleHold(index);
      },
    );
  }

  Widget _buildRollButton(BuildContext context) {
    final scene = Provider.of<GameScene>(context);
    return RaisedButton.icon(
      highlightColor: Colors.white30,
      splashColor: Colors.white54,
      icon: Icon(MdiIcons.diceMultipleOutline),
      label: scene.tries != 0
          ? Text('Roll again (${scene.maxTries - scene.tries} left)')
          : Text('Roll now!'),
      onPressed: scene.canRoll ? () => scene.roll() : null,
    );
  }

  Widget _guideMessage(BuildContext context) {
    return GuideMessage();
  }

  Widget _swipeUpIndicatorMobile(BuildContext context) {
    final scene = Provider.of<GameScene>(context, listen: false);
    if (!scene.canRoll) {
      return Blinking(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < 3; i++)
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.black38,
                  ),
              ],
            ),
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget _endingScreen(BuildContext context) {
    final scene = Provider.of<GameScene>(context, listen: false);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Your total score'),
        Text('${scene.totalScore}',
            style: textTheme.headline.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        Text('Number of Flutzies'),
        Text('${scene.allStreak}', style: textTheme.headline),
        SizedBox(height: 16),
        Text('High score'),
        Text('420', style: textTheme.headline),
      ],
    );
  }
}

class GuideMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 48,
      ),
      child: AnimatedSwitcher(
        duration: standardFadeDuration,
        child: _guideContent(context),
      ),
    );
  }

  Widget _guideContent(BuildContext context) {
    final scene = Provider.of<GameScene>(context, listen: false);
    if (scene.tries == 0) {
      return Text(
        'Round ${scene.round}\n'
        'Start by rolling the dice',
        textAlign: TextAlign.center,
      );
    } else if (scene.canRoll) {
      return Text(
        'Tap a dice to toggle hold.\n'
        'You can keep rolling up to 3 times',
        textAlign: TextAlign.center,
      );
    } else {
      return isMobile
          ? Text('Swipe up to score in and end turn')
          : Text('Choose a score on the right to end turn');
    }
  }
}
