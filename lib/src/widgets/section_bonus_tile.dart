import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutzy/src/utils/constants.dart';
import 'package:flutzy/src/widgets/ticking_number.dart';

class SectionBonusTile extends StatelessWidget {
  final int currentScore;
  final int maxScore;

  const SectionBonusTile({
    Key key,
    @required this.currentScore,
    @required this.maxScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: scoreTileHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Bonus:',
            style: TextStyle(fontFamily: 'RobotoCondensed'),
          ),
          Spacer(),
          TickingNumber(
            currentScore,
            duration: tickingNumberDuration,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text('/$maxScore'),
        ],
      ),
    );
  }
}
