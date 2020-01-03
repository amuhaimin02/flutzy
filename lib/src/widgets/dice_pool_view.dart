import 'package:flutter/material.dart';
import 'package:flutzy/src/models/dice_pool.dart';
import 'package:flutzy/src/utils/groupable_list.dart';

import 'dice_view.dart';

class DicePoolView extends StatelessWidget {
  final DicePool pool;

  const DicePoolView({Key key, this.pool}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var diceRow in pool.content.group(3))
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var dice in diceRow)
                Padding(
                  padding: EdgeInsets.all(8),
                  child: DiceView(dice),
                ),
            ],
          ),
      ],
    );
  }
}
