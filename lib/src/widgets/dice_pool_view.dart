import 'package:flutter/material.dart';
import 'package:flutzy/src/models/dice.dart';
import 'package:flutzy/src/models/dice_pool.dart';
import 'package:flutzy/src/utils/constants.dart';
import 'package:flutzy/src/utils/groupable_list.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'dice_view.dart';

class DicePoolView extends StatelessWidget {
  final DicePool pool;
  final Function(int) onSelected;

  const DicePoolView({Key key, this.pool, @required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: standardFadeDuration,
      child: pool.content != DicePool.emptyDicePool
          ? _dicePoolContent()
          : EmptyDicePoolPlaceholder(),
    );
  }

  Widget _dicePoolContent() {
    int i = 0;
    return Column(
      children: [
        for (var diceRow in pool.content.group(3))
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var dice in diceRow) _diceFace(i++, dice),
            ],
          ),
      ],
    );
  }

  Widget _diceFace(int index, Dice dice) {
    return GestureDetector(
      onTap: () => onSelected(index),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: DiceView(
          dice,
          faceColor: pool.diceOnHold[index] ? Colors.red : Colors.white,
          dotColor: pool.diceOnHold[index] ? Colors.white : Colors.black54,
        ),
      ),
    );
  }
}

class EmptyDicePoolPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (diceFaceSize + 16) * 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Start by rolling the dice'),
          SizedBox(height: 16),
          Icon(MdiIcons.diceMultipleOutline,
              size: diceFaceSize, color: Theme.of(context).primaryColor),
        ],
      ),
    );
  }
}
