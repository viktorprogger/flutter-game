import 'package:flutter/material.dart';
import 'package:game/fight/character.dart';
import 'package:game/fight/map.dart';
import 'package:game/fight/state.dart';
import 'package:provider/provider.dart';

class BattleBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BattleBoardState(map: FightBoardMap.generate(width: 7, height: 10));
  }
}

class BattleBoardState extends State<BattleBoard> {
  final FightBoardMap map;

  BattleBoardState({required this.map});

  @override
  Widget build(BuildContext context) {
    int height = map.tiles[0].length;
    int width = map.tiles.length;

    return Material(
      child: Stack(
        children: [
          // Positioned(child: Text('Hero is here')),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List<Widget>.generate(
                map.tiles.length,
                (column) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List<Widget>.generate(
                      map.tiles[0].length,
                      (row) => false && row == height - 1 && column == width ~/ 2
                          ? Expanded(
                              child:HeroWidget(
                                character: HeroCharacter(
                                  tile: map.tiles[column][row]
                                ),
                              )
                            )
                          : MonsterWidget(tile: map.tiles[column][row], ),
                    ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class MonsterWidget extends StatefulWidget {

  final MapTile tile;
  late Monster character = Monster.random(tile: tile);

  MonsterWidget({required this.tile});

  @override
  State<StatefulWidget> createState() {
    return MonsterState(tile: tile, character: character);
  }
}

class MonsterState extends State<MonsterWidget>
    with SingleTickerProviderStateMixin {

  final MapTile tile;
  final Monster character;

  MonsterState({required this.tile, required this.character});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<FightBoardState>(
        builder: (context, state, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: Offset(0, state.getMoveOffset(tile).toDouble())
            ).animate(
              CurvedAnimation(
                parent: AnimationController(
                  duration: const Duration(seconds: 2),
                  vsync: this,
                ), curve: Curves.ease
              )
            ),
            child:GestureDetector(
              onTap: () => print('test1'),
              child: FractionallySizedBox(
                widthFactor: 0.8,
                heightFactor: 0.8,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.blueGrey),
                  child: Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: state.isPressed(character.tile) ? Colors.blue : Colors.pink,
                  )
                ),
              )
            ),
          );
        },
      )
    );
  }
}

class HeroWidget extends StatelessWidget {
  final Character character;

  HeroWidget({required this.character});

  @override
  Widget build(BuildContext context) {
    return Consumer<FightBoardState>(
      builder: (context, state, child) {
        return new Icon(
          Icons.self_improvement,
          color: state.isPressed(character.tile) ? Colors.blue : Colors.pink,
        );
      },
    );
  }
}
