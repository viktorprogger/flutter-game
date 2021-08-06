import 'dart:math';

import 'package:game/fight/map.dart';

enum CharacterType {
  Hero,
  Monster,
}

abstract class Character {
  final CharacterType type;
  final MapTile tile;

  Character({required this.type, required this.tile});
}

class HeroCharacter extends Character {
  HeroCharacter({required MapTile tile}) : super(type: CharacterType.Hero, tile: tile);
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
