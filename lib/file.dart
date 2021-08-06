import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

// <editor-fold Map>
class Map {
  late List<List<MapTile>> tiles;

  Map(this.tiles);

  Map.generate({required int width, required int height}) {
    tiles = List.generate(height,
        (x) => List.generate(width, (y) => MapTile(x, y, TileType.GROUND)));
  }
}

enum TileType {
  GROUND,
  // Here will be some more: rocks, water, etc.
}

class MapTile {
  final int x;
  final int y;
  final type;

  MapTile(this.x, this.y, this.type);
}

// </editor-fold>

// <editor-fold Characters>
enum CharacterType {
  Hero,
  Monster,
}

abstract class Character {
  final CharacterType type;
  final MapTile tile;

  Character({required this.type, required this.tile});
}

class Hero extends Character {
  Hero({required MapTile tile}) : super(type: CharacterType.Hero, tile: tile);
}

enum MonsterType {
  Red,
  Blue,
  Yellow,
}

class Monster extends Character {
  late MonsterType monsterType;

  Monster({required MapTile tile, required this.monsterType})
      : super(type: CharacterType.Monster, tile: tile);

  Monster.random({required MapTile tile})
      : super(type: CharacterType.Monster, tile: tile) {
    int idx = (new Random()).nextInt(MonsterType.values.length - 1);
    monsterType = MonsterType.values.toList(growable: false)[idx];
  }
}

// </editor-fold>

// <editor-fold Widget>
class BattleBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BattleBoardState(map: Map.generate(width: 7, height: 10));
  }
}

class BattleBoardState extends State<BattleBoard> {
  late Hero _hero;
  final Map map;

  BattleBoardState({required this.map});

  @override
  Widget build(BuildContext context) {
    // _hero = Hero();

    int width = map.tiles[0].length;
    int height = map.tiles.length;
    int length = width * height;

    var list = List.generate(length, (index) {
      int column = index % (width);
      int row = index ~/ (width);

      if (row == height - 1 && column == width ~/ 2) {
        return HeroWidget(
          hero: Hero(
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
  final Hero hero;

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
// </editor-fold>
