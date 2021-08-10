import 'package:flutter/material.dart';
import 'package:game/fight/map.dart';
import 'package:game/fight/state.dart';
import 'package:game/fight/widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FightBoardState(FightBoardMap.generate(width: 7, height: 10)),
      child: MaterialApp(
        home: Scaffold(
          body: BattleBoard(),
        ),
      ),
    );
  }
}
