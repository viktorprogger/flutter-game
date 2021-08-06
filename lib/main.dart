import 'package:flutter/material.dart';
import 'package:game/fight/widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BattleBoard(),
      ),
    );
  }
}
