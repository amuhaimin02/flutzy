import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutzy/src/models/dice.dart';
import 'package:flutzy/src/models/dice_pool.dart';
import 'package:flutzy/src/utils/constants.dart';
import 'package:flutzy/src/utils/groupable_list.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'dice_view.dart';

class DicePoolView extends StatefulWidget {
  final DicePool pool;
  final Function(int) onSelected;

  const DicePoolView({Key key, this.pool, @required this.onSelected})
      : super(key: key);

  @override
  _DicePoolViewState createState() => _DicePoolViewState();
}

class _DicePoolViewState extends State<DicePoolView>
    with SingleTickerProviderStateMixin {
  static final _random = Random();

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Stores the last dice status. This is more like a hack
  var lastDicePool;

  @override
  void didUpdateWidget(DicePoolView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Only animate the change when there is differences in dice pool value.
    if (widget.pool.content != DicePool.emptyDicePool &&
        !identical(lastDicePool, widget.pool.content)) {
      _controller.forward(from: 0);
    }

    lastDicePool = widget.pool.content;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: fastFadeDuration,
      child: widget.pool.content != DicePool.emptyDicePool
          ? _dicePoolContent()
          : EmptyDicePoolPlaceholder(),
    );
  }

  Widget _dicePoolContent() {
    int i = 0;
    return Column(
      children: [
        for (var diceRow in widget.pool.content.group(3))
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var dice in diceRow) _animatedDiceFace(dice, i++),
            ],
          ),
      ],
    );
  }

  Widget _animatedDiceFace(Dice dice, int index) {
    return GestureDetector(
      onTap: () => widget.onSelected(index),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return widget.pool.diceOnHold[index] == false
                ? Transform.rotate(
                    angle: sin(_controller.value * 4 * pi) * 0.05 * pi,
                    child: _controller.status == AnimationStatus.completed
                        ? child
                        : _diceView(Dice.values[_random.nextInt(6)], index),
                  )
                : child;
          },
          child: _diceView(dice, index),
        ),
      ),
    );
  }

  Widget _diceView(Dice dice, int index) {
    return DiceView(
      dice,
      faceColor: widget.pool.diceOnHold[index] ? Colors.red : Colors.white,
      dotColor: widget.pool.diceOnHold[index] ? Colors.white : Colors.grey[700],
    );
  }
}

class EmptyDicePoolPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (diceFaceSize + 16) * 2,
      child: Icon(MdiIcons.diceMultipleOutline,
          size: diceFaceSize, color: Theme.of(context).primaryColor),
    );
  }
}
