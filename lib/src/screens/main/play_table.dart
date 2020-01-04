import 'package:flutter/material.dart';
import 'package:flutzy/src/models/game_scene.dart';
import 'package:flutzy/src/widgets/dice_pool_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class FlutzyPlayTable extends StatelessWidget {
  const FlutzyPlayTable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _diceDisplay(context),
          SizedBox(height: 40),
          _buildRollButton(context),
        ],
      ),
    );
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
      label: Text('Roll (${scene.tries}/${scene.maxTries})'),
      onPressed: scene.canRoll ? () => scene.roll() : null,
    );
  }
}
