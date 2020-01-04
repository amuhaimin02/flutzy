import 'package:flutter/material.dart';

import 'screens/main/main_screen.dart';

class FlutzyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutzy',
      theme: themeFrom(color: (colorPalette..shuffle()).first),
      home: FlutzyMainScreen(),
    );
  }

  ThemeData themeFrom({MaterialColor color}) {
    return ThemeData(
      primarySwatch: color,
      accentColor: color,
      bottomAppBarColor: color.shade200,
      splashColor: color.withOpacity(0.54),
      highlightColor: color.withOpacity(0.36),
      scaffoldBackgroundColor: color.shade50,
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        height: 56,
        minWidth: 240,
      ),
      textTheme: Typography.englishLike2018,
      splashFactory: InkRipple.splashFactory,
    );
  }
}

var colorPalette = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
//  Colors.lightBlue,
//  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
//  Colors.lime,
//  Colors.yellow,
//  Colors.amber,
//  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
//  Colors.grey,
  Colors.blueGrey
];
