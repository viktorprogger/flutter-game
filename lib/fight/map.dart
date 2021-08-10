class FightBoardMap {
  late List<List<MapTile>> tiles;

  FightBoardMap(this.tiles);

  FightBoardMap.generate({required int width, required int height}) {
    tiles = List.generate(
        width,
        (y) => List.generate(
          height,
          (x) => MapTile(y, x, TileType.GROUND)
        )
    );
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
