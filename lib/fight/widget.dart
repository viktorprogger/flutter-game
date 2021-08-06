import 'package:flutter/material.dart';
import 'package:game/fight/character.dart';
import 'package:game/fight/map.dart';

class BattleBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BattleBoardState(map: Map.generate(width: 7, height: 10));
  }
}

class BattleBoardState extends State<BattleBoard> {
  late HeroCharacter _hero;
  final Map map;

  BattleBoardState({required this.map});

  @override
  Widget build(BuildContext context) {
    // _hero = HeroCharacter();

    int width = map.tiles[0].length;
    int height = map.tiles.length;
    int length = width * height;

    var list = List.generate(length, (index) {
      int column = index % (width);
      int row = index ~/ (width);

      if (row == height - 1 && column == width ~/ 2) {
        return HeroWidget(
          hero: HeroCharacter(
            tile: map.tiles[row][column],
          ),
        );
      }

      return MonsterWidget(
        character:
        Monster(monsterType: MonsterType.Red, tile: map.tiles[row][column]),
      );
    });

    return Material(
        child: GridView.count(
          crossAxisCount: width,
          physics: NeverScrollableScrollPhysics(),
          children: list,
        )
    );
  }
}

class MonsterWidget extends StatelessWidget {
  final Character character;

  MonsterWidget({required this.character});

  @override
  Widget build(BuildContext context) {
    IconData icon = character.type == CharacterType.Hero
        ? Icons.self_improvement
        : Icons.sentiment_very_dissatisfied;

    return new Icon(
      icon,
    );
  }
}

class HeroWidget extends StatefulWidget {
  final HeroCharacter hero;

  HeroWidget({required this.hero});

  @override
  State<StatefulWidget> createState() {
    return new HeroState();
  }
}

class HeroState extends State<HeroWidget> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerDown: (PointerDownEvent event) => setState(() => _pressed = true),
        onPointerUp: (PointerUpEvent event) => setState(() => _pressed = false),
        child: Container(
            width: 800,
            child: Icon(
              Icons.self_improvement,
              color: _pressed ? Colors.blue : Colors.pink,
            )
        )
    );
  }
}
