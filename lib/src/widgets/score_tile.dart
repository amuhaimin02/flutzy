import 'package:flutter/material.dart';
import 'package:flutzy/src/models/score_type.dart';
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

    return Container(
      color: enabled ? Colors.transparent : Colors.black12,
      child: ListTile(
        leading: Icon(data.icon),
        enabled: enabled,
        title: Text(
          data.name,
          style: TextStyle(
            fontFamily: 'RobotoCondensed',
          ),
        ),
        onTap: onTap,
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
  ScoreType.ones: ScorePanelData(name: 'One', icon: MdiIcons.dice1Outline),
  ScoreType.twos: ScorePanelData(name: 'Two', icon: MdiIcons.dice2Outline),
  ScoreType.threes: ScorePanelData(name: 'Three', icon: MdiIcons.dice3Outline),
  ScoreType.fours: ScorePanelData(name: 'Four', icon: MdiIcons.dice4Outline),
  ScoreType.fives: ScorePanelData(name: 'Five', icon: MdiIcons.dice5Outline),
  ScoreType.sixes: ScorePanelData(name: 'Six', icon: MdiIcons.dice6Outline),
  ScoreType.threeOfAKind:
      ScorePanelData(name: '3-of-a-kind', icon: MdiIcons.numeric3CircleOutline),
  ScoreType.fourOfAKind:
      ScorePanelData(name: '4-of-a-kind', icon: MdiIcons.numeric4CircleOutline),
  ScoreType.fullHouse:
      ScorePanelData(name: 'Full house', icon: MdiIcons.homeOutline),
  ScoreType.smallStraight: ScorePanelData(
      name: 'Small straight', icon: MdiIcons.arrowRightDropCircleOutline),
  ScoreType.largeStraight: ScorePanelData(
      name: 'Large straight', icon: MdiIcons.arrowRightCircleOutline),
  ScoreType.fiveOfAKind:
      ScorePanelData(name: '5-of-a-kind', icon: MdiIcons.numeric5CircleOutline),
  ScoreType.chance:
      ScorePanelData(name: 'Chance', icon: MdiIcons.helpCircleOutline),
};
