import 'package:flutter/material.dart';
import 'package:flutzy/src/models/score_type.dart';
import 'package:flutzy/src/widgets/strikable_text.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';



class ScorePanelTile extends StatelessWidget {
  final VoidCallback onTap;
  final ScoreType type;
  final enabled;

  const ScorePanelTile({
    Key key,
    this.type,
    this.enabled = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = scorePanelDataOf[type];

    return InkWell(
      onTap: enabled ? onTap : null,
      child: Container(
        color: enabled ? Colors.transparent : Colors.black12,
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: scoreTileHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(data.icon, color: enabled ? Colors.black54 : Colors.black38),
            AnimatedStrikableText(
              data.name,
              strike: !enabled,
              style: TextStyle(
                fontFamily: 'RobotoCondensed',
                color: enabled ? Colors.black87 : Colors.black38,
              ),
              lineColor: Theme.of(context).errorColor.withOpacity(0.54),
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
class ScorePanelData {
  final IconData icon;
  final String name;

  const ScorePanelData({this.name, this.icon});
}

const scorePanelDataOf = {
  ScoreType.ones: ScorePanelData(name: 'Ones', icon: MdiIcons.dice1Outline),
  ScoreType.twos: ScorePanelData(name: 'Twos', icon: MdiIcons.dice2Outline),
  ScoreType.threes: ScorePanelData(name: 'Threes', icon: MdiIcons.dice3Outline),
  ScoreType.fours: ScorePanelData(name: 'Fours', icon: MdiIcons.dice4Outline),
  ScoreType.fives: ScorePanelData(name: 'Fives', icon: MdiIcons.dice5Outline),
  ScoreType.sixes: ScorePanelData(name: 'Sixes', icon: MdiIcons.dice6Outline),
  ScoreType.threeOfAKind:
      ScorePanelData(name: '3 of a kind', icon: MdiIcons.numeric3CircleOutline),
  ScoreType.fourOfAKind:
      ScorePanelData(name: '4 of a kind', icon: MdiIcons.numeric4CircleOutline),
  ScoreType.fullHouse:
      ScorePanelData(name: 'Full house', icon: MdiIcons.homeOutline),
  ScoreType.smallStraight: ScorePanelData(
      name: 'Small straight', icon: MdiIcons.arrowRightDropCircleOutline),
  ScoreType.largeStraight: ScorePanelData(
      name: 'Large straight', icon: MdiIcons.arrowRightCircleOutline),
  ScoreType.fiveOfAKind:
      ScorePanelData(name: '5 of a kind', icon: MdiIcons.numeric5CircleOutline),
  ScoreType.chance:
      ScorePanelData(name: 'Chance', icon: MdiIcons.helpCircleOutline),
};
