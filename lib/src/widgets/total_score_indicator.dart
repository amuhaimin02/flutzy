import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutzy/src/utils/constants.dart';
import 'package:flutzy/src/widgets/ticking_number.dart';

class TotalScoreIndicator extends StatelessWidget {
  final VoidCallback onTap;
  final int score;

  const TotalScoreIndicator({Key key, this.score, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      onLongPress: () {},
      child: DefaultTextStyle(
        style: TextStyle(
          color: Colors.black54,
          letterSpacing: 0.8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _currentScoreText(),
            _divider(),
            _highScoreText(),
          ],
        ),
      ),
    );
  }

  Widget _currentScoreText() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPress: _onCurrentScorePanelSelected,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Score: ',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          TickingNumber(
            score,
            duration: Duration(milliseconds: 600),
            curve: Curves.easeOut,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 2,
      height: 10,
      color: Colors.black12,
      margin: EdgeInsets.symmetric(vertical: 32),
    );
  }

  Widget _highScoreText() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPress: _onHighScorePanelSelected,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'High score',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 4),
          TickingNumber(
            420,
            duration: tickingNumberDuration,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  void _onCurrentScorePanelSelected() {
    print('Curernt score tapped');
    HapticFeedback.mediumImpact();
  }

  void _onHighScorePanelSelected() {
    print('High score tapped');
    HapticFeedback.mediumImpact();
  }
}
