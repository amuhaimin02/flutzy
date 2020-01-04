import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutzy/src/utils/constants.dart';
import 'package:flutzy/src/widgets/strikable_text.dart';
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
    final bonusObtained = currentScore >= maxScore;

    return Container(
      color: bonusObtained
          ? Colors.black12
          : Theme.of(context).primaryColor.withOpacity(0.1),
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: scoreTileHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedStrikableText(
            'Sect. bonus',
            strike: bonusObtained,
            style: TextStyle(
              fontFamily: 'RobotoCondensed',
              color: bonusObtained ? Colors.black38 : Colors.black87,
            ),
            lineColor: Theme.of(context).errorColor.withOpacity(0.54),
            thickness: 2,
          ),
          Spacer(),
          if (bonusObtained)
            Text('+35 ',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black38))
          else ...[
            TickingNumber(
              currentScore,
              duration: slowFadeDuration,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('/$maxScore')
          ],
        ],
      ),
    );
  }
}
