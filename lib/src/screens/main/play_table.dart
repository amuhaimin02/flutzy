import 'package:flutter/material.dart';
import 'package:flutzy/src/models/game_scene.dart';
import 'package:flutzy/src/widgets/dice_pool_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class FlutzyPlayTable extends StatelessWidget {
  // Instead of passing data like this, consider to
  // use other suitable method (Provider?)
  final VoidCallback onScoreInPressed;

  const FlutzyPlayTable({Key key, this.onScoreInPressed}) : super(key: key);

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
    final pool = Provider.of<GameScene>(context, listen: false).dicePool;
    return DicePoolView(pool: pool);
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
          duration: Duration(milliseconds: 300),
          child: FlatButton(
            child: Text('Score in'),
            onPressed: scene.hasRolled ? onScoreInPressed : null,
          ),
        );
      },
    );
  }
}
