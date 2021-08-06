import 'dart:math';

enum MonsterType {
  Red,
  Blue,
  Yellow,
}

enum CharacterType {
  Hero,
  Monster,
}

abstract class Character {
  final CharacterType type;

  Character(this.type);
}

class Hero extends Character {
  Hero() : super(CharacterType.Hero);
}

class Monster extends Character {
  late MonsterType monsterType;

  Monster(this.monsterType) : super(CharacterType.Monster);

  Monster.random() : super(CharacterType.Monster) {
    int idx = (new Random()).nextInt(MonsterType.values.length - 1);
    monsterType = MonsterType.values.toList(growable: false)[idx];
  }
}

class MapTile {
  final int x;
  final int y;
  final Character character;

  MapTile(this.x, this.y, this.character);
}

class FightMap {
  final int width;
  final int height;
  late List<List<MapTile>> tiles;
  final Random random = new Random();

  FightMap(this.width, this.height) {
    _generate();
  }

  void _generate() {
    tiles = List.generate(width, (x) => List.generate(height, (y) => _generateTile(x, y)));
    int center = (width/2).round();
    tiles[center][height - 1] = new MapTile(center, height - 1, Hero());
  }

  MapTile _generateTile(int x, int y) {
    return MapTile(x, y, Monster.random());
  }
}
